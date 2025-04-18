#!/bin/bash
define_helpers() {
  empty() {
    [[ -z $1 ]]
  }

  not_empty() {
    [[ -n $1 ]]
  }

  isset() {
    [[ -v $1 ]]
  }

  command_exists() {
    command -v "$1" >/dev/null 2>&1;
  }

  error() {
    echo "$COLOR_RED$*$COLOR_RESET"
  }

  ms_to_secs() {
    echo $(( ($1 + (1000 - 1)) / 1000 ))
  }

  has_capability() {
    [[ "${NOTIFY_CAPS[*]}" =~ $1 ]]
  }

  max() {
    echo $(( $1 > $2 ? $1 : $2 ))
  }
}

define_pulseaudio_functions() {
  pa_list_sinks() {
    if $OPT_LISTEN || empty "$PA_LIST_SINKS"; then
      PA_LIST_SINKS=$(pactl list sinks)
    fi
    echo "$PA_LIST_SINKS"
  }

  pa_invalidate_cache() {
    unset PA_LIST_SINKS
  }

  pa_get_volume() {
    local -r sink=${1:?$(error 'Sink name is required')}

    pactl get-sink-volume $sink | \
      awk -W posix '/^Volume: / {gsub("%,?", ""); print $5; exit}'
  }

  pa_increase_volume() {
    local -r sink=$1
    local -r step=${2:=-5}
    pa_set_volume "$sink" "+${step}%"
  }

  pa_decrease_volume() {
    local -r sink=$1
    local -r step=${2:=-5}
    pa_set_volume "$sink" "-${step}%"
  }

  pa_set_volume() {
    local -r sink=${1:?$(error 'Sink name is required')}
    local -r vol=${2:?$(error 'Volume is required')}
    pa_invalidate_cache
    pactl set-sink-volume "$sink" "$vol"
  }

  pa_toggle_mute() {
    local -r sink=${1:?$(error 'Sink name is required')}
    pa_invalidate_cache
    pactl set-sink-mute "$sink" toggle
  }

  pa_toggle_mute_mic() {
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
  }

  pa_is_muted() {
    local -r sink=${1:?$(error 'Sink name is required')}

    pa_list_sinks | \
      awk -W posix '/^[ \t]+Name: / {insink = $2 == "'"$sink"'"}
          /^[ \t]+Mute: / && insink && $2 ~ /^yes$/ { exitcode=1 }; END { exit !exitcode }'
  }
}

define_light_functions() {
  light_get_brightness() {
    printf "%.0f" $(($(brightnessctl get)*100/$(brightnessctl max)))
  }

  light_increase_brightness() {
    brightnessctl set "$1%+"
  }

  light_decrease_brightness() {
    brightnessctl set "$1%-"
  }

  light_set_brightness() {
    brightnessctl set "$1%"
  }
}

setup_pulseaudio() {
  define_pulseaudio_functions

  PA_LIST_SINKS=$(pactl list sinks) || exit 1

  if empty "$SINK"; then
    SINK="$(pactl get-default-sink)"
  fi
}

setup_light() {
  define_light_functions
}

progress_bar() {
  local -r percent=${1:?$(error 'Percentage is required')}
  local -r max_percent=${2:-100}
  local -r divisor=${3:-5}
  local -r progress=$(( (percent > max_percent ? max_percent : percent) / divisor ))

  printf -v bar "%*s" $progress ""
  echo "${bar// /█}"
}

notify() {
  local -r id=${1:?$(error 'Identify is required')}
  local -r value=${2:?$(error 'Value is required')}
  local -r summary=${3}
  local -a args=(-t "$EXPIRES")
  local -a hints=(
    # Replaces previous notification in some notification servers
    string:synchronous:${id}
    # Replaces previous notification in NotifyOSD
    string:x-canonical-private-synchronous:${id}
  )
  if ! $SHOW_VOLUME_PROGRESS; then
    hints+=(int:value:"$vol")
  fi
  read -ra hints <<< "${hints[@]/#/-h }"
  notify-send "${hints[@]}" "${args[@]}" "$summary"
}

notify_volume() {
  local -r vol=$(get_volume)
  local summary

  if is_muted; then
    summary="Volume muted"
  else
    printf -v summary "Volume %3s%%" "$vol"
    if $SHOW_VOLUME_PROGRESS; then
      local -r progress=$(progress_bar "$vol")

      summary="$summary $progress"
    fi
  fi

  notify "volume" "$vol" "$summary"
}

notify_brightness() {
  local -r bright=$(get_brightness)
  local summary

  printf -v summary "Brightness %3s%%" "$bright"
  if $SHOW_VOLUME_PROGRESS; then
    local -r progress=$(progress_bar "$bright")

    summary="$summary $progress"
  fi

  notify "brightness" "$bright" "$summary"
}

define_volume_commands() {
  get_volume() {
    pa_get_volume "$SINK"
  }

  is_muted() {
    pa_is_muted "$SINK"
    return $?
  }

  increase_volume() {
    local step=${1:?$(error 'Step is required')}
    local -r max_volume=$2
    if not_empty "$max_volume"; then
      local -r vol=$(get_volume)
      if (( vol >= max_volume )); then
        return
      elif (( vol + step > max_volume )); then
        step=$( max "0" "$(( max_volume - vol ))" )
      fi
    fi
    pa_increase_volume "$SINK" "$step"
  }

  decrease_volume() {
    local -r step=${1:?$(error 'Step is required')}
    pa_decrease_volume "$SINK" "$step"
  }

  set_volume() {
    local -r vol=${1:?$(error 'Volume is required')}
    local -r max_volume=$2
    if not_empty "$max_volume" && (( vol >= max_volume )); then
      return
    fi
    pa_set_volume "$SINK" "${vol}%"
  }

  toggle_mute() {
    pa_toggle_mute "$SINK"
  }

  toggle_mute_mic() {
    pa_toggle_mute_mic
  }
}

define_brightness_commands() {
  get_brightness() {
    light_get_brightness
  }

  increase_brightness() {
    light_increase_brightness "$1"
  }

  decrease_brightness() {
    light_decrease_brightness "$1"
  }

  set_brightness() {
    light_set_brightness "$1"
  }
}

define_commands() {
  usage() {
    cat <<- EOF 1>&2
Usage: $0 <volume_commands>|<brightness_commands> [<options>] <command> [<args>]
Control volume/brightness and related notifications.
EOF
    exit
  }

  define_volume_commands
  define_brightness_commands
}

exec_volume() {
  COMMAND=$1
  shift

  case "$COMMAND" in
    up|raise|increase)
      case "$#" in 1) ;; *) usage ;; esac
      increase_volume "$1" "$MAX_VOLUME" && notify_volume
      ;;
    down|lower|decrease)
      case "$#" in 1) ;; *) usage ;; esac
      decrease_volume "$1" && notify_volume
      ;;
    get)
      case "$#" in 0) ;; *) usage ;; esac
      notify_volume
      ;;
    set)
      case "$#" in 1) ;; *) usage ;; esac
      case "$1" in
        +*) increase_volume "${1:1}" "$MAX_VOLUME" && notify_volume ;;
        -*) decrease_volume "${1:1}" && notify_volume ;;
        *) set_volume "$1" "$MAX_VOLUME" && notify_volume ;;
      esac
      ;;
    mute)
      case "$#" in 0) ;; *) usage ;; esac
      toggle_mute && notify_volume
      ;;
    mute_mic)
      case "$#" in 0) ;; *) usage ;; esac
      toggle_mute_mic
      ;;
    *)
      usage
      ;;
  esac
}

exec_brightness() {
  COMMAND=$1
  shift

  case "$COMMAND" in
    up|raise|increase)
      case "$#" in 1) ;; *) usage ;; esac
      increase_brightness "$1" && notify_brightness
      ;;
    down|lower|decrease)
      case "$#" in 1) ;; *) usage ;; esac
      decrease_brightness "$1" && notify_brightness
      ;;
    get)
      case "$#" in 0) ;; *) usage ;; esac
      notify_brightness
      ;;
    set)
      case "$#" in 1) ;; *) usage ;; esac
      case "$1" in
        +*) increase_brightness "${1:1}" && notify_brightness ;;
        -*) decrease_brightness "${1:1}" && notify_brightness ;;
        *) set_brightness "$1" && notify_brightness ;;
      esac
      ;;
    *)
      usage
      ;;
  esac
}

exec_command() {
  COMMAND=$1
  shift

  case "$COMMAND" in
    volume)
      exec_volume "$@"
      ;;
    brightness)
      exec_brightness "$@"
      ;;
    *)
      usage
      ;;
  esac
}

main() {
  declare \
    COMMAND \
    SHOW_VOLUME_PROGRESS=true \
    SINK

  declare -i \
    EXPIRES=1500 \
    MAX_VOLUME=200

  define_helpers
  define_commands
  setup_pulseaudio
  setup_light
  exec_command "$@"
}

main "$@"

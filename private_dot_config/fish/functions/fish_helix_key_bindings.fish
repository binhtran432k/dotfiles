function fish_helix_key_bindings --description 'helix-like key bindings for fish'
    if contains -- -h $argv
        or contains -- --help $argv
        echo "Sorry but this function doesn't support -h or --help" >&2
        return 1
    end

    # Erase all bindings if not explicitly requested otherwise to
    # allow for hybrid bindings.
    # This needs to be checked here because if we are called again
    # via the variable handler the argument will be gone.
    set -l rebind true
    if test "$argv[1]" = --no-erase
        set rebind false
        set -e argv[1]
    else
        bind --erase --all --preset # clear earlier bindings, if any
    end

    # Allow just calling this function to correctly set the bindings.
    # Because it's a rather discoverable name, users will execute it
    # and without this would then have subtly broken bindings.
    if test "$fish_key_bindings" != fish_helix_key_bindings
        and test "$rebind" = true
        __fish_change_key_bindings fish_helix_key_bindings || return
    end

    set -l init_mode insert

    if contains -- $argv[1] insert default visual
        set init_mode $argv[1]
    else if set -q argv[1]
        # We should still go on so the bindings still get set.
        echo "Unknown argument $argv" >&2
    end

    # Inherit shared key bindings.
    # Do this first so helix-bindings win over default.
    for mode in insert default visual
        __fish_shared_key_bindings -s -M $mode
    end

    # Add a way to switch from insert to normal (command) mode.
    # Note if we are paging, we want to stay in insert mode
    # See #2871
    set -l on_escape '
        if commandline -P
            commandline -f cancel
        else
            set fish_bind_mode default
            if test (count (commandline --cut-at-cursor | tail -c2)) != 2
                commandline -f backward-char
            end
            commandline -f repaint-mode
        end
    '

    bind -s --preset h end-selection backward-char
    bind -s --preset -M visual h backward-char

    bind -s --preset l end-selection forward-char
    bind -s --preset -M visual l forward-char

    bind -s --preset k __fish_helix_end_selection_if up-or-search
    bind -s --preset -M visual k up-line

    bind -s --preset j __fish_helix_end_selection_if down-or-search
    bind -s --preset -M visual j down-line

    bind -s --preset g,g end-selection beginning-of-buffer
    bind -s --preset -M visual g,g beginning-of-buffer

    bind -s --preset g,e end-selection end-of-buffer
    bind -s --preset -M visual g,e end-of-buffer

    bind -s --preset g,h end-selection beginning-of-line
    bind -s --preset -M visual g,h beginning-of-line

    bind -s --preset g,l end-selection end-of-line
    bind -s --preset -M visual g,l end-of-line

    bind -s --preset ';' end-selection
    bind -s --preset -M visual ';' end-selection

    bind -s --preset b '__fish_helix_prev_word default backward-word'
    bind -s --preset -M visual b '__fish_helix_prev_word visual backward-word'

    bind -s --preset B '__fish_helix_prev_word default backward-bigword'
    bind -s --preset -M visual B '__fish_helix_prev_word visual backward-bigword'

    bind -s --preset w '__fish_helix_next_word default forward-word'
    bind -s --preset -M visual w '__fish_helix_next_word visual forward-word'

    bind -s --preset W '__fish_helix_next_word default forward-bigword'
    bind -s --preset -M visual W '__fish_helix_next_word visual forward-bigword'

    bind -s --preset e '__fish_helix_next_word_end default forward-word'
    bind -s --preset -M visual e '__fish_helix_next_word_end visual forward-word'

    bind -s --preset E '__fish_helix_next_word_end default forward-bigword'
    bind -s --preset -M visual E '__fish_helix_next_word_end visual forward-bigword'

    bind -s --preset -m visual v __fish_helix_begin_selection_if_not repaint-mode
    bind -s --preset -M visual -m default v repaint-mode

    bind -s --preset -m insert i end-selection repaint-mode
    bind -s --preset -M visual -m insert i end-selection repaint-mode

    bind -s --preset -m insert I end-selection beginning-of-line repaint-mode
    bind -s --preset -M visual -m insert I end-selection beginning-of-line repaint-mode

    bind -s --preset -m insert a end-selection forward-single-char repaint-mode
    bind -s --preset -M visual -m insert a end-selection forward-single-char repaint-mode

    bind -s --preset -m insert A  end-selection end-of-line repaint-mode
    bind -s --preset -M visual -m insert A end-selection end-of-line repaint-mode

    bind -s --preset -m insert o end-selection insert-line-under repaint-mode
    bind -s --preset -M visual -m insert o end-selection insert-line-under repaint-mode

    bind -s --preset -m insert O end-selection insert-line-over repaint-mode
    bind -s --preset -M visual -m insert O end-selection insert-line-over repaint-mode

    bind -s --preset -m insert c __fish_helix_delete_selection_or_char end-selection repaint-mode
    bind -s --preset -M visual -m insert c kill-selection end-selection repaint-mode

    bind -s --preset d __fish_helix_delete_selection_or_char end-selection
    bind -s --preset -M visual -m default d kill-selection end-selection repaint-mode

    bind -s --preset x __fish_helix_expand_line_selection forward-single-char
    bind -s --preset -M visual x __fish_helix_expand_line_selection forward-single-char

    bind -s --preset % beginning-of-buffer begin-selection end-of-buffer
    bind -s --preset -M visual % beginning-of-buffer begin-selection end-of-buffer

    bind -s --preset m,m jump-to-matching-bracket
    bind -s --preset -M visual m,m jump-to-matching-bracket

    bind -s --preset f begin-selection forward-jump
    bind -s --preset -M visual f forward-jump

    bind -s --preset F begin-selection backward-jump
    bind -s --preset -M visual F backward-jump

    bind -s --preset t begin-selection forward-jump-till
    bind -s --preset -M visual t forward-jump-till

    bind -s --preset T begin-selection backward-jump-till
    bind -s --preset -M visual T backward-jump-till

    bind -s --preset -M insert escape $on_escape
    bind -s --preset -M visual -m default escape end-selection repaint-mode
    bind -s --preset -M replace_one -m default escape cancel repaint-mode

    bind -s --preset -M insert ctrl-\[ $on_escape
    bind -s --preset -M visual -m default ctrl-\[ end-selection repaint-mode
    bind -s --preset -M replace_one -m default ctrl-\[ cancel repaint-mode

    bind -s --preset '~' togglecase-selection
    bind -s --preset -M visual '~' togglecase-selection

    bind -s --preset y __fish_helix_yank_selection_or_char
    bind -s --preset -M visual -m default y __fish_helix_yank_selection_or_char repaint-mode

    bind -s --preset space,y __fish_helix_clipboard_selection_or_char
    bind -s --preset -M visual -m default space,y __fish_helix_clipboard_selection_or_char repaint-mode

    bind -s --preset p '__fish_helix_paste_yank forward'
    bind -s --preset -M visual -m default p forward-char yank

    bind -s --preset P '__fish_helix_paste_yank backward'
    bind -s --preset -M visual -m default P yank

    bind -s --preset R '__fish_helix_paste_yank self'
    bind -s --preset -M visual -m default R kill-selection yank yank-pop

    bind -s --preset space,p '__fish_helix_paste_clipboard forward'
    bind -s --preset -M visual -m default space,p forward-char fish_clipboard_paste

    bind -s --preset space,P '__fish_helix_paste_clipboard backward'
    bind -s --preset -M visual -m default space,P fish_clipboard_paste

    bind -s --preset space,R '__fish_helix_paste_clipboard self'
    bind -s --preset -M visual -m default space,R kill-selection yank-pop fish_clipboard_paste

    bind -s --preset space,c __fish_toggle_comment_commandline
    bind -s --preset -M visual -m default space,c __fish_toggle_comment_commandline repaint-mode

    bind -s --preset -m insert ctrl-c clear-commandline repaint-mode
    bind -s --preset -M visual -m default ctrl-c end-selection repaint-mode

    bind -s --preset -m replace_one r end-selection repaint-mode
    bind -s --preset -M replace_one -m default '' begin-selection kill-selection end-selection self-insert backward-char repaint-mode

    bind -s --preset [ history-token-search-backward

    bind -s --preset ] history-token-search-forward

    bind -s --preset u undo

    bind -s --preset U redo

    bind -s --preset J end-of-line delete-char

    bind -s --preset :,q exit

    bind -s --preset -m insert enter execute
    bind -s --preset -m insert ctrl-j execute
    bind -s --preset -m insert ctrl-m execute

    bind -s --preset -m insert / history-pager repaint-mode

    bind -s --preset -M insert ctrl-n accept-autosuggestion

    # Vi/Vim doesn't support these keys in insert mode but that seems silly so we do so anyway.
    bind -s --preset -M insert home beginning-of-line
    bind -s --preset -M default home beginning-of-line
    bind -s --preset -M insert end end-of-line
    bind -s --preset -M default end end-of-line

    bind -s --preset -M insert delete delete-char

    # Backspace deletes a char in insert mode, but not in normal/default mode.
    bind -s --preset -M insert backspace backward-delete-char
    bind -s --preset -M insert shift-backspace backward-delete-char
    bind -s --preset -M insert ctrl-h backward-delete-char

    # Set the cursor shape
    # After executing once, this will have defined functions listening for the variable.
    # Therefore it needs to be before setting fish_bind_mode.
    fish_vi_cursor
    set -g fish_cursor_selection_mode inclusive
    function __fish_helix_key_bindings_on_mode_change --on-variable fish_bind_mode
        switch $fish_bind_mode
            case insert replace
                set -g fish_cursor_end_mode exclusive
            case '*'
                set -g fish_cursor_end_mode inclusive
        end
    end
    function __fish_helix_key_bindings_remove_handlers --on-variable __fish_active_key_bindings
        __fish_vi_cursor fish_cursor_default
        functions --erase __fish_helix_key_bindings_remove_handlers
        functions --erase __fish_helix_key_bindings_on_mode_change
        functions --erase fish_vi_cursor_handle
        functions --erase fish_vi_cursor_handle_preexec

        functions --erase __fish_helix_prev_word
        functions --erase __fish_helix_next_word
        functions --erase __fish_helix_next_word_end
        functions --erase __fish_helix_delete_selection_or_cha
        functions --erase __fish_helix_begin_selection_if_no
        functions --erase __fish_helix_end_selection_i
        functions --erase __fish_helix_expand_line_selectio
        functions --erase __fish_helix_yank_selection_or_cha
        functions --erase __fish_helix_clipboard_selection_or_cha
        functions --erase __fish_helix_paste_yank
        functions --erase __fish_helix_paste_clipboard
        functions --erase __fish_helix__cursor_end_selection

        set -e -g fish_cursor_end_mode
        set -e -g fish_cursor_selection_mode
    end

    function __fish_helix_prev_word -a mode action
        if test $mode = default
            set -f cursor (math (commandline -C))
            if test $cursor = 0
                return
            end
            set -f curr_match (string sub -s $cursor (commandline -b) -l 2)
            if string match -qr '^\s[^\s]$' -- $curr_match
                commandline -f backward-char
            end
            commandline -f begin-selection
        end
        commandline -f $action
    end
    function __fish_helix_next_word -a mode action
        if test $mode = default
            set -f cursor (math (commandline -C) + 1)
            set -f curr_match (string sub -s $cursor (commandline -b) -l 2)
            if string match -qr '^\s[^\s]$' -- $curr_match
                commandline -f forward-char
            end
            commandline -f begin-selection
        end
        commandline -f $action
    end
    function __fish_helix_next_word_end -a mode action
        set fish_cursor_end_mode exclusive
        if test $mode = default
            set -f cursor (math (commandline -C) + 1)
            set -f curr_match (string sub -s $cursor (commandline -b) -l 2)
            if string match -qr '^[^\s]\s$' -- $curr_match
                commandline -f forward-char
            end
            commandline -f begin-selection
        end
        commandline -f forward-single-char $action backward-char
        set fish_cursor_end_mode inclusive
    end
    function __fish_helix_delete_selection_or_char
        if test -z "$(commandline -s)"
            commandline -f delete-char
        else
            commandline -f kill-selection
        end
    end
    function __fish_helix_begin_selection_if_not
        if test -z "$(commandline -s)"
            commandline -f begin-selection
        end
    end
    function __fish_helix_expand_line_selection
        if test -z "$(commandline -s)"
            commandline -f beginning-of-line begin-selection end-of-line
        else
            set -f selection_start (commandline -B)
            set -f selection_end (commandline -E)
            commandline -C $selection_start
            commandline -f beginning-of-line begin-selection
            commandline -C $selection_end
            commandline -f end-of-line
        end
    end
    function __fish_helix_end_selection_if
        if test -n "$(commandline -s)"
            commandline -f end-selection
        end
    end
    function __fish_helix_yank_selection_or_char
        if test -z "$(commandline -s)"
            commandline -f begin-selection kill-selection yank end-selection
        else
            set -f selection_start (commandline -B)
            set -f selection_end (commandline -C)
            if test $selection_end = $selection_start
                set -f selection_start (math (commandline -E) - 1)
            end
            commandline -f kill-selection yank
            commandline -C $selection_start
            commandline -f begin-selection
            commandline -C $selection_end
        end
    end
    function __fish_helix_clipboard_selection_or_char
        if test -z "$(commandline -s)"
            commandline -f begin-selection
            fish_clipboard_copy
            commandline -f end-selection
        else
            fish_clipboard_copy
        end
    end
    function __fish_helix_paste_yank -a direction
        if test "$direction" = self
            if test -z "$(commandline -s)"
                commandline -f delete-char yank
            else
                set -f selection_start (commandline -B)
                set -f selection_end (math (commandline -E) - 1)
                __fish_helix__cursor_end_selection forward
                commandline -f yank
                commandline -C $selection_start
                commandline -f begin-selection
                commandline -C $selection_end
                commandline -f kill-selection end-selection
            end
        else
            __fish_helix__cursor_end_selection $direction
            commandline -f yank
        end
    end
    function __fish_helix_paste_clipboard -a direction
        if test "$direction" = self
            if test -z "$(commandline -s)"
                commandline -f delete-char
            else
                commandline -f kill-selection end-selection
            end
            fish_clipboard_paste
        else
            __fish_helix__cursor_end_selection $direction
            fish_clipboard_paste
        end
    end
    function __fish_helix__cursor_end_selection -a direction
        set -g fish_cursor_end_mode exclusive
        if test -z "$(commandline -s)"
            if test "$direction" = forward
                commandline -f forward-char
            end
        else
            if test "$direction" = forward
                set -f cursor (commandline -E)
                commandline -f end-selection
                commandline -C $cursor
            else
                set -f cursor (commandline -B)
                commandline -f end-selection
                commandline -C $cursor
            end
        end
        set -g fish_cursor_end_mode inclusive
    end

    set fish_bind_mode $init_mode
end

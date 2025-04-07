if type -q starship
    if [ "$TERM" != "linux"  ]
        starship init fish | source
    end
end

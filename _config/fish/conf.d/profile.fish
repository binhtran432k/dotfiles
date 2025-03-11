set profile_path "~/.profile"
if test -n $PROFILE_FLAG; and test -d $profile_path
    source $profile_path
end

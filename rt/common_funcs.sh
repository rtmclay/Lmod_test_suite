init()
{
  eval $($projectDir/tools/cleanEnv)
  ORIG_HOME=$HOME
  HOME=$outputDir

  while IFS='=' read -r name value; do
    if [ "$name" = "LMOD_CMD" ] || [ "$name" = "LMOD_DIR" ]; then
        :
    elif [[ "$name" =~ ^__LMOD_REF_COUNT.* ]]; then
        unset $name
    elif [[ "$name" =~ ^LMOD.* ]]; then
        unset $name
    fi
  done < <(env)

  export LMOD_RTM_TESTING=1

  rm -rf _stderr.orig
  cp $projectDir/{.bashrc,.bash_profile} $outputDir
}

cleanUp ()
{
   sed                                                    \
       -e "s|$outputDir|OutputDIR|g"                      \
       -e "s|$projectDir|ProjectDIR|g"                    \
       -e "s| *----* *||g"                                \
       -e "s|^--* *| |g"                                  \
       -e "s|--* *$||g"                                   \
       -e "s|$HOME|~|g"                                   \
       -e "/^ *$/d"                                       \
       < $1 > $2
}

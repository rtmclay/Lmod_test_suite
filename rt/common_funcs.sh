init()
{
  eval $($projectDir/tools/cleanEnv)
  ORIG_HOME=$HOME
  HOME=$outputDir
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

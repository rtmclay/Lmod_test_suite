runBase ()
{
   COUNT=$(($COUNT + 1))
   numStep=$(($numStep+1))
   NUM=`printf "%03d" $numStep`
   echo "===========================" >  _stderr.$NUM
   echo "step $COUNT"                 >> _stderr.$NUM
   echo "$@"                          >> _stderr.$NUM
   echo "===========================" >> _stderr.$NUM

   echo "===========================" >  _stdout.$NUM
   echo "step $COUNT"                 >> _stdout.$NUM
   echo "$@"                          >> _stdout.$NUM
   echo "===========================" >> _stdout.$NUM

   numStep=$(($numStep+1))
   NUM=`printf "%03d" $numStep`
   "$@" > _stdout.$NUM 2>> _stderr.$NUM
}

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
       -e "s|$HOME|~|g"                                   \
       -e "/^ *$/d"                                       \
       < $1 > $2
}

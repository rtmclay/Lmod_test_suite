init()
{
  unsetMT
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
unsetMT ()
{
   unset _ModuleTable_
   local last
   last=1000
   if [ -n "$_ModuleTable_Sz_" ]; then
       last=$_ModuleTable_Sz_
       unset _ModuleTable_Sz_
   fi
   for ((i=1; i<=last; i++)); do
      num=`printf %03d $i`
      eval j="\$_ModuleTable${num}_"
      if [ -z "$j" ]; then
         break
      fi
      unset _ModuleTable${num}_
   done

   if [ -n $_ModuleTable_Sz_ ]; then
       unset _ModuleTable_Sz_
   fi
   last=1000
   for ((i=1; i<=last; i++)); do
      num=`printf %03d $i`
      eval j="\$_ModuleTable_${num}_"
      if [ -z "$j" ]; then
         break
      fi
      unset _ModuleTable_${num}_
   done
   while IFS='=' read -r name value ; do
     if [[ $name =~ __LMOD_REF_COUNT_ ]]; then
       unset $name
     fi
   done < <(env)
}

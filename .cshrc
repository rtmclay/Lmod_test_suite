set system=`uname -s`
if ( $system == Darwin ) then
   source /tmp/lmod/lmod/init/cshrc

   if ( !  $?__INIT_MODULES ) then
      setenv __INIT_MODULES 1
   else
      module refresh
   endif
endif

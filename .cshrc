which module >& /dev/null
if ( $status != 0) then
   source /tmp/lmod/lmod/init/cshrc
endif
if ( !  $?__INIT_MODULES ) then
   setenv __INIT_MODULES 1
else
   module refresh
endif

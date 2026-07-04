if ! command -v module > /dev/null ; then
  .     /tmp/lmod/lmod/init/profile
fi  

if [ -z "${__INIT_MODULES:-}" ]; then
  export __INIT_MODULES=1
else
  module refresh
fi

system=$(uname -s)

if [ "$system" = Darwin ] && [ -f /tmp/lmod/lmod/init/profile ]; then
  .     /tmp/lmod/lmod/init/profile

  if [ -z "${__INIT_MODULES:-}" ]; then
    export __INIT_MODULES=1
  else
    module refresh
  fi
fi

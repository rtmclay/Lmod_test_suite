if [ -z "${__INIT_MODULES:-}" ]; then
  export __INIT_MODULES=1
else
  module refresh
fi

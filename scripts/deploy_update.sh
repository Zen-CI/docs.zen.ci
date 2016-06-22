#!/bin/sh

echo "Full site path: $DOCROOT"

# Go to domain directory.
cd $DOCROOT

echo "Process contrib"
for project in `cat $ZENCI_DEPLOY_DIR/settings/contrib.list`; do
  if [ "$project" == "radix_layouts" ];then 
    # See issue: https://github.com/backdrop-contrib/radix_layouts/issues/9
    $B -y dl $project --type=layout
  else
    $B -y dl $project
  fi
done

#fix for radix
#if [ ! -L "$HOME/github/backdrop-contrib/radix_layouts/default" ]; then
#  ln -s $HOME/github/backdrop-contrib/radix_layouts/default $DOCROOT/layouts/contrib/radix_layouts
#fi

echo "Enable Modules"

for module in `cat $ZENCI_DEPLOY_DIR/settings/modules.enable`; do
  echo "Enable $module"
  $B -y --root="$DOCROOT" en $module
done

$B -y --root="$DOCROOT" cc all

echo "Import Docs"

$B -y --root="$DOCROOT" github-pages-update


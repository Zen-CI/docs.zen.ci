#!/bin/sh


echo "Full site path: $DOCROOT"

# Go to domain directory.
cd $DOCROOT

echo "Process contrib"
for project in `cat $ZENCI_DEPLOY_DIR/settings/contrib.list`; do
  repo=`echo $project|awk -F/ '{print$1}'`
  branch=`echo $project|awk -F/ '{print$2}'`
  
  sh $ZENCI_DEPLOY_DIR/scripts/contrib.sh $repo $branch
done

#fix for radix
if [ ! -L "$HOME/github/backdrop-contrib/radix_layouts/default" ]; then
  ln -s $HOME/github/backdrop-contrib/radix_layouts/default $DOCROOT/layouts/contrib/radix_layouts
fi

echo "Enable Modules"

for module in `cat $ZENCI_DEPLOY_DIR/settings/modules.enable`; do
  echo "Enable $module"
  php $ZENCI_DEPLOY_DIR/scripts/console.sh --root="$DOCROOT" --enable $module
done

php $ZENCI_DEPLOY_DIR/scripts/console.sh --root="$DOCROOT" --cleancache

echo "Import Docs"
php $ZENCI_DEPLOY_DIR/modules/github_pages/github_pages_shell.php --root $DOCROOT


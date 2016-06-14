#!/bin/sh


echo "Full site path: $DOCROOT"

# Go to domain directory.
cd $DOCROOT

echo "Contrib modules"
sh $ZENCI_DEPLOY_DIR/scripts/contrib_modules.sh

echo "Contrib themes"
sh $ZENCI_DEPLOY_DIR/scripts/contrib_themes.sh

echo "Contrib layouts"
sh $ZENCI_DEPLOY_DIR/scripts/contrib_layouts.sh


echo "Enable Modules"

for module in `cat $ZENCI_DEPLOY_DIR/settings/modules.enable`; do
  echo "Enable $module"
  php $ZENCI_DEPLOY_DIR/scripts/console.sh --root="$DOCROOT" --enable $module
done

php $ZENCI_DEPLOY_DIR/scripts/console.sh --root="$DOCROOT" --cleancache

echo "Import Docs"
php $ZENCI_DEPLOY_DIR/modules/github_pages/github_pages_shell.php --root $DOCROOT


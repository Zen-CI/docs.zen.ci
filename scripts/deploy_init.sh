#!/bin/sh

#install backdrop
sh $ZENCI_DEPLOY_DIR/scripts/backdrop_install.sh

echo "Full site path: $DOCROOT"

# Go to domain directory.
cd $DOCROOT

echo "Link documentation"
ln -s $ZENCI_DEPLOY_DIR/Documentation $DOCROOT/files/Documentation

echo "Linking modules from $ZENCI_DEPLOY_DIR"

mkdir -p $DOCROOT/modules/contrib
mkdir -p $DOCROOT/themes/contrib
mkdir -p $DOCROOT/layouts/contrib
mkdir -p $DOCROOT/libraries/contrib

#copy config
cp $ZENCI_DEPLOY_DIR/settings/config/*.json $DOCROOT/files/config/active/
sed -i "s|DEPLOY_DIR|$ZENCI_DEPLOY_DIR|g" $DOCROOT/files/config/active/github_pages.settings.json

cp $ZENCI_DEPLOY_DIR/settings/config/config.htaccess $DOCROOT/files/config/.htaccess

cd $DOCROOT/modules
ln -s $ZENCI_DEPLOY_DIR/modules ./custom

cd $DOCROOT/themes
ln -s $ZENCI_DEPLOY_DIR/themes ./custom

cd $DOCROOT/layouts
ln -s $ZENCI_DEPLOY_DIR/layouts ./custom

cd $DOCROOT/libraries
ln -s $ZENCI_DEPLOY_DIR/libraries ./custom

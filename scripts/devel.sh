#!/bin/sh

PWD=`pwd`

export DOCROOT="$PWD/.devel/docroot"
export DATABASE_NAME="docs_devel"
export DATABASE_USER="docs_devel"
export DATABASE_PASS="docs_devel"
export DATABASE_SERVER="127.0.0.1"

export ACCOUNT_MAIL="admin@zen.ci"
export ACCOUNT_USER="admin"
export ACCOUNT_PASS="123"
export SITE_MAIL="noreply@zen.ci"
export SITE_NAME="localcopy docs.zen.ci"
export B="php /Users/gor/Sites/Repositories/GitHub/Gormartsen/b/b.php"
export ZENCI_DEPLOY_DIR="$PWD"
export DEPLOY_DIR="$PWD"

if [ ! -d "$DOCROOT" ]; then
  mkdir -p $DOCROOT
  
  #prepare database access
  mysqladmin -uroot create $DATABASE_NAME
  mysql -u root mysql -e "CREATE USER '"$DATABASE_USER"'@'localhost';"
  mysql -u root mysql -e "GRANT ALL ON $DATABASE_NAME.* TO '"$DATABASE_USER"'@'localhost' IDENTIFIED BY '"$DATABASE_PASS"';"
  
  echo "$DATABASE_PASS" > /tmp/$DOMAIN.pass
  export DATABASE_PASS_FILE="/tmp/$DOMAIN.pass"
  sh $PWD/scripts/deploy_init.sh

fi

sh $PWD/scripts/deploy_update.sh

cd $DOCROOT
php -S localhost:8080 routing.php

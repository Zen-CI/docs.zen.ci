# About this repository
This is the documentation site for ZenCI! (http://docs.zen.ci/)

## How to contribute
Before you can contribute, you need to have a compatible DEV environment:
- Linux or MacOS
- php 5.4 or higher version.
- MySQL

To initialize your dev copy:

1. Fork & clone this repository
2. Update with proper credential script `scripts/devel.sh` if necessary. 
3. start php built in web server:
```
# sh scripts/devel.sh
.....
Listening on http://localhost:8080
```

Now you can go to http://localhost:8080 and see Documentation copy site.

You can edit any Documentation/*.md file and see changes immediately. 

If you add new file, just interrupt devel.sh with CTRL+C and start again.
It will rebuilt menu structure automatically.

## Structure
- Documentation - contain markdown files with instructions.
- files - files from this directory will be available under http://docs.zen.ci/files/github/
- modules - backdropCMS modules for this project
- scripts - devOPS scripts to handle QA, dev and production deploy.
- settings - devOPS settings
- themes - backdropCMS themes for this project

## Need more information?

Please visit our [Gitter.im chat](http://gitter.im/Zen-CI/chat)

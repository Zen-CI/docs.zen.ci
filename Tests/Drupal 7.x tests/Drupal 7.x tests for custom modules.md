# Drupal 7.x tests for custom modules

**This guide is for Drupal developers who want to implement Continuous integration to automatize development process**

> Most good programmers do programming not because they expect to get paid or get adulation by the public, but because it is fun to program. ~Linus Torvalds

This guide extend:
- [Deploy  Drupal 7.x](http://docs.zen.ci/deploy/deploy-drupal-7x)
- [QA server for Drupal 7.x](http://docs.zen.ci/qa-server/qa-server-drupal-7x)
- [Drupal 7.x tests](http://docs.zen.ci/tests/drupal-7x-tests)
Please check it before continue.


#### Testing custom modules

Add your custom module to folder **modules** and put module name to **settings/enable.list** file.

Usually, you don't need to run all **core** tests for your module tests.

For this guide we will use module [Views 7.x-3.x-dev](https://www.drupal.org/project/views).

We added **views**  module to **modules** folder and 'views views_ui' to file **settinsg/enable.list**. 

Also we replaced **env_vars: tests** by **--directory sites/all/modules/custom/views**

As soon as code pushed to repository, test started:

![VIews test](http://docs.zen.ci/files/Screen_Shot_2016-06-12_at_7.56.44_PM.png) 

*Test time depends on selected machine and amount of tests.*

[Test result](https://zen.ci/ZenCI-example/drupal-starter-kit/test/test-php53-ZenCI-example_drupal-starter-kit_master-7292):

![Views test](http://docs.zen.ci/files/Screen_Shot_2016-06-12_at_8.24.25_PM.png) 

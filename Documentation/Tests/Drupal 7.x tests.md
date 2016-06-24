# Drupal 7.x tests

**This guide is for Drupal developers who want to implement Continuous integration to automatize development process**

> Quality means doing it right even when no one is looking. ~Henry Ford

This guide extend:
- [Deploy  Drupal 7.x](http://docs.zen.ci/Deploy/Deploy%20Drupal%207.x)
- [QA server for Drupal 7.x](http://docs.zen.ci/QA%20server/QA%20server%20for%20Drupal%207.x)

Please check it before continue.

#### 1. Update .zen.ci file with necessary information

**drupal-starter-kit** contain almost ready **.testing.zenci.yml** file. 

Copy **tests** section from  **.testing.zenci.yml** file and replace **REPLACE\_WITH\_%** with proper credentials and details:

```yaml
test:
  php53:
    branch:
      box: 'octo-leam-php53'
      dir: '{home}/github'
      env_vars:
        docroot: '{home}/www'
        domain: 'localhost'
        database_name: 'test'
        database_user: 'test'
        database_pass: ''
        account_user: admin
        account_mail: admin@zen.ci
        account_pass: REPLACE_WITH_ADMIN_PASSWORD
        site_mail: noreply@zen.ci
        site_name: 'branch {branch} tests for {repo_owner}/{repo_name}'
        tests: '--all'
      scripts:
        init: '{deploy_dir}/scripts/test_deploy_init.sh'
      tests:
        - '{deploy_dir}/scripts/drupal_tests.php'
    pull_request:
      box: 'octo-leam-php53'
      dir: '{home}/github'
      env_vars:
        docroot: '{home}/www'
        domain: 'localhost'
        database_name: 'test'
        database_user: 'test'
        database_pass: ''
        account_user: admin
        account_mail: admin@zen.ci
        account_pass: REPLACE_WITH_ADMIN_PASSWORD
        site_mail: noreply@zen.ci
        site_name: 'pr {pr_number} branch {branch} tests for {repo_owner}/{repo_name}'
        tests: '--all'
      scripts:
        init: '{deploy_dir}/scripts/test_deploy_init.sh'
      tests:
        - '{deploy_dir}/scripts/drupal_tests.php'
```

When you **push** changes for **.zenci.yml** file  **ZenCI** will start all **Drupal 7** tests.
![ZenCI](http://docs.zen.ci/files/Screen_Shot_2016-06-12_at_4.37.16_PM.png) 

Test time depends on selected machine and amount of tests.

https://github.com/Zen-CI/drupal-starter-kit optimized to run **Drupal 7** tests.

- **octo-leam-php53** - It's **CentOS6** based machine with **8 vCPU** and **7.2GB RAM**. **PHP5.3** run with **xcache**
- **test_deploy_init.sh** - this script does next:
    - install **Drupal 7.x** from git repository,
    - moves **Database** into **/dev/shm** to affect **MySQL** performance 
    - enable **simpletest** module
-  **drupal_tests.php** - start custom version of **run-tests.sh** and report back to **ZenCI** tests status and short **summary**
-  **run-tests.sh** - is version of original **scripts/run-tests.sh** from **Drupal 7** core. It contain **--summary** option for **drupal_tests.php**. **--verbose** output also changed to display only **fail** and **exception** details.

When tests finished - timeline updated with status:

![timeline](http://docs.zen.ci/files/Screen_Shot_2016-06-12_at_5.20.52_PM.png) 

[Test log](https://zen.ci/ZenCI-example/drupal-starter-kit/test/test-php53-ZenCI-example_drupal-starter-kit_master-7281) has a full log as well:

![test log](http://docs.zen.ci/files/Screen_Shot_2016-06-12_at_5.21.48_PM.png) 


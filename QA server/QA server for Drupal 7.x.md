# QA server for Drupal 7.x

**This guide is for Drupal developers who want to implement Continuous integration to automatize development process**

> Quality is the ally of schedule and cost, not their adversary. If we have to sacrifice quality to meet schedule, it’s because we are doing the job wrong from the very beginning.  ~James A. Ward

This guide extend [Deploy  Drupal 7.x](http://docs.zen.ci/deploy/deploy-drupal-7x)

Before we start, you need to have:
- a [Github account](https://github.com).
- server with root permission. VPS fits best.
- domain name for QA server. We will use qa.drupal7.examples.zen.ci for this guide. 

**You need to point your domain, include subdomains (wildcard) to your VPS IP.** So all *.qa.drupal7.examples.zen.ci websites will be pointed to VPS IP as well.

#### 1. Server setup

You can choose any type of OS that you know better. This guide is based on **CentOS 7** but most of this steps are easy to reproduce on any other Linux based Distributive.

We selected [DigitalOcean](https://www.digitalocean.com) to setup a QA server.
After install finished and we get root access we installed necessary software.

There is a ready to go install script: [centos-7-qa-server-drupal-install.sh](https://github.com/Zen-CI/scripts/blob/master/centos-7-qa-server-drupal-install.sh)
You can copy paste next command to your shell:
```bash
wget https://raw.githubusercontent.com/Zen-CI/scripts/master/centos-7-qa-server-drupal-install.sh -O centos-7-qa-server-drupal-install.sh
sh  centos-7-qa-server-drupal-install.sh
```

As a result we have:
- apache, mysql (mariadb) and php7 (mod_php) up and running
- test user with permission to restart apache
- root access without password to create and destroy databases
- virtual host template 

#### 2. Github & **ZenCI** site

This guide extend [Deploy  Drupal 7.x](http://docs.zen.ci/deploy/deploy-drupal-7x). Please check it before continue.

**Don't forget** to properly setup **/home/test/.ssh/authorized_keys** file. You need to copy public_key to this file.

See details in  [Deploy  Drupal 7.x  -> 4. **ZenCI** site](http://docs.zen.ci/deploy/deploy-drupal-7x#ssh) section 

Make sure that you have **.ssh** folder and permissions is set to **0600** on file authorized_keys and **0700** on **.ssh** folder . 

It is **security** requirements.


#### 3. Update .zen.ci file with necessary information

**drupal-starter-kit** contain almost ready **.qa.zenci.yml** file. 
Rename your current **branch** section to **master**. This way you tell **ZenCI** to deploy branch **master** to your hosting. 

Keyword **branch** is a wildcard for all branches. 

We need to point them to **QA** server. **master** branch will be pointed to **production** environment on hosting account for **drupal7.examples.zen.ci**. 

Copy **branch** and  **pull_request** to **deploy** section from  **.qa.zenci.yml** file and replace **REPLACE\_WITH\_%** with proper credentials and details:

```yaml
  branch:
    server: qa.drupal7.examples.zen.ci
    username: test
    dir: '{home}/github/{repo_owner}/{repo_name}/branch/{branch}'
    env_vars:
      docroot: '{home}/domains/{branch}.qa.drupal7.examples.zen.ci'
      domain: '{branch}.qa.drupal7.examples.zen.ci'
      database_name: 'test_{branch}'
      database_user: 'test_{branch}'
      database_pass: 'test_{branch}'
      account_user: admin
      account_mail: admin@zen.ci
      account_pass: REPLACE_WITH_ADMIN_PASSWORD
      site_mail: noreply@zen.ci
      site_name: '{branch} QA site for {repo_owner}/{repo_name}'
      default_theme: "bootstrap_lite"
      enable_devel: "yes"
    scripts:
      init: '{deploy_dir}/scripts/qa_deploy_init.sh'
      after: '{deploy_dir}/scripts/deploy_update.sh'
      remove: '{deploy_dir}/scripts/qa_deploy_remove.sh'
  pull_request:
    server: qa.drupal7.examples.zen.ci
    username: test
    dir: '{home}/github/{repo_owner}/{repo_name}/pr/{pr_number}'
    env_vars:
      docroot: '{home}/domains/{pr_number}.{branch}.qa.drupal7.examples.zen.ci'
      domain: '{pr_number}.{branch}.qa.drupal7.examples.zen.ci'
      database_name: 'test_{branch}_{pr_number}'
      database_user: 'test_{branch}_{pr_number}'
      database_pass: 'test_{branch}_{pr_number}'
      account_user: admin
      account_mail: admin@zen.ci
      account_pass: REPLACE_WITH_ADMIN_PASSWORD
      site_mail: noreply@zen.ci
      site_name: '{pr_number} {branch} QA site for {repo_owner}/{repo_name}'
      default_theme: "bootstrap_lite"
      enable_devel: "yes"
    scripts:
      init: '{deploy_dir}/scripts/qa_deploy_init.sh'
      after: '{deploy_dir}/scripts/deploy_update.sh'
      remove: '{deploy_dir}/scripts/qa_deploy_remove.sh'
```

**Compare your .zenci.yml file with [ZenCI-example/drupal-starter-kit/.zenci.yml](https://github.com/ZenCI-example/drupal-starter-kit/blob/master/.zenci.yml)**

#### 4. Creating new branch.

Go back on GitHub and create a branch **dev** from your master.

**ZenCI** will create a separated site on **QA** server for this branch under name http://dev.qa.drupal7.examples.zen.ci

![dev](http://docs.zen.ci/files/Screen_Shot_2016-06-12_at_3.52.58_PM.png) 

You can update **scripts/qa_deploy_init.sh** script to use latest production database dump to make a dev copy of your website.

![dev deploy](http://docs.zen.ci/files/Screen_Shot_2016-06-12_at_3.53.15_PM.png) 

Deploy log for new branch **dev** available [here](https://zen.ci/ZenCI-example/drupal-starter-kit/deploy/deploy-ZenCI-example_drupal-starter-kit_dev-7264).

**When you delete branch, domain, database and github cloned code for branch will be deleted.**

#### 5. Creating PR to master from dev.

Before we create a **PR** we need to add changes to **dev**. Lets switch theme to **seven**.

Create file settings/update/switch_theme_seven.sh**
```bash
#!/bin/sh

echo "Set default theme seven"
drush -y en seven
drush vset theme_default seven
```

As soon as we commit it to **dev** branch, **ZenCI** [deploy this script](https://zen.ci/ZenCI-example/drupal-starter-kit/deploy/deploy-ZenCI-example_drupal-starter-kit_dev-7270) and theme get changed to **seven**

![dev seven](http://docs.zen.ci/files/Screen_Shot_2016-06-12_at_4.03.07_PM.png) 

Now we can create  **PR** to **master**.
**ZenCI** [process](https://zen.ci/ZenCI-example/drupal-starter-kit/deploy/deploy-ZenCI-example_drupal-starter-kit_2-7272) this request and create http://2.dev.qa.drupal7.examples.zen.ci website that already has theme **seven** as default.

![pr deploy](http://docs.zen.ci/files/Screen_Shot_2016-06-12_at_4.07.26_PM.png) 

**When you close PR - domain, database and github cloned code for PR will be deleted.**

#### 6. What next?

Now you have **QA** server, where you can test new functionality and deploy it to production when it's ready.

Please read [README.md](https://github.com/Zen-CI/drupal-starter-kit/blob/master/README.md) for more details.

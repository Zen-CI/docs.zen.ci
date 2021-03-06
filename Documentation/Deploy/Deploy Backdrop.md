# Deploy BackdropCMS

**This guide is for new users to Continuous integration.**

> Continuous Integration (CI) is a development practice that requires developers to integrate code into a shared repository several times a day. Each check-in is then verified by an automated build, allowing teams to detect problems early.
By integrating regularly, you can detect errors quickly, and locate them more easily.
>  
>  [link to original article](https://www.thoughtworks.com/continuous-integration)

Before we start, you need to have:
- a [Github account](https://github.com). Please sign up now,  if you do not already have one.
- a hosting account for our website.

You don't have to have VPS or Cloud hosting to use benefits of **ZenCI**. We need only SSH access to deploy code.

#### 1. Hosting  

Go to your hosting provider control panel and make sure that you created:
- database - we will use **zenci_backdrop1** for this guide
- database user  - we will use ** zenci_backdrop1** for this guide. 
- database password - we will use **DBPASSWORD** for this guide
- domain name - we will use **http://backdrop1.examples.zen.ci** for this guide. 


#### 2. Github

We encourage you to have **private** repository for your projects that contain sensitive information like passwords or even user data.

- for **private** repository option - download code from https://github.com/Zen-CI/backdrop-starter-kit and push it into your repository.
- for **public** repository - you can fork https://github.com/Zen-CI/backdrop-starter-kit.


#### 3. **ZenCI** site.

Go to http://zen.ci/sign-in and click 'Public' to log in on **ZenCI** website and provide access to your public repository.
Use 'Private' to give access to private repository.
It will redirect you on github.com to ask you grant such permissions to ZenCI.
After you approve this request, you get forwarded back on **ZenCI** website to page where you can see your own repositories.

![Enable](http://docs.zen.ci/files/Screen_Shot_2016-06-12_at_12.27.16_PM.png) 

Please click [Enable] button for this new repository.

We need to allow **ZenCI** to access your hosting account via SSH. 

On settings page for this repository you can see a public key for SSH access:
![SSH](http://docs.zen.ci/files/Screen_Shot_2016-06-12_at_12.29.30_PM.png) 

Copy public key to file **~/.ssh/authorized_keys** on your hosting account. 
Make sure that you have **.ssh** folder and permissions is set to **0600** on file authorized_keys and **0700** on **.ssh** folder . 

It is **security** requirements.


#### 4. Update **.zen.ci** file with necessary information

**backdrop-starter-kit** contain almost ready **.zenci.yml** file. 
Please replace **REPLACE\_WITH\_%** with proper credentials and details:

```yaml
deploy:
  branch:
    server: backdrop1.examples.zen.ci
    username: zenci
    dir: '{home}/github/{repo_owner}/{repo_name}/{branch}'
    env_vars:
      docroot: '{home}/domains/backdrop1.examples.zen.ci'
      domain: 'backdrop1.examples.zen.ci'
      database_name: zenci_backdrop1
      database_user: zenci_backdrop1
      database_pass: DBPASSWORD
      account_user: admin@zen.ci
      account_mail: admin@zen.ci
      account_pass: REPLACE_WITH_ADMIN_PASSWORD
      site_mail: noreply@zen.ci
      site_name: 'backdrop-starter-kit example 1.'
    scripts:
      init: '{deploy_dir}/scripts/deploy_init.sh'
```

Now you can see what **ZenCI** is reacting on your action repo page.
![ZenCI](http://docs.zen.ci/files/Screen_Shot_2016-06-12_at_12.38.00_PM.png) 

**ZenCI** provide [deploy log](https://zen.ci/ZenCI-example/backdrop-starter-kit/deploy/deploy-ZenCI-example_backdrop-starter-kit_master-7227):

![deploy log](http://docs.zen.ci/files/Screen_Shot_2016-06-12_at_12.39.53_PM.png) 

**Congratulations!** You deployed your [Backdrop site](http://backdrop1.examples.zen.ci)!

#### 5. What next?

Now you can deploy your custom modules, themes and layouts automatically to your website as soon as you push code to your repository.
Please read [README.md](https://github.com/Zen-CI/backdrop-starter-kit/blob/master/README.md) for more details.

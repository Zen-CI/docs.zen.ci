# Test Boxes information

We provide various **Test Boxes** with pre-installed and pre-configured OS and software.
**Remember** - there is no concurrent job limit. We start tests as soon as you push code or send PR.
However, we can experience physical limit to serve tests. In this case we process tests as soon as test box is available.

#### 1. .zenci.yml configuration.
You define a box type by providing 'box' variable in **.zenci.yml** file.

```yaml
test:
  REPLACE_WITH_TAG:
    branch:
      box: REPLACE_WITH_BOX_NAME
      dir: '{home}/github/branch/{branch}'
      scripts:
        init: REPLACE_WITH_INIT_SCRIPT_PATH
      tests:
        - REPLACE_WITH_TEST_SCRIPT_PATH_1
        - REPLACE_WITH_TEST_SCRIPT_PATH_N
    pull_request:
      box: REPLACE_WITH_BOX_NAME
      dir: '{home}/github/pr/{pr_number}'
      scripts:
        init: REPLACE_WITH_INIT_SCRIPT_PATH
      tests:
        - REPLACE_WITH_TEST_SCRIPT_PATH_1
        - REPLACE_WITH_TEST_SCRIPT_PATH_N
```

- **REPLACE_WITH_TAG** - this variable will be used in context for **GitHub** status. Example: php53 here will generate status: `zenci/tests/php53/branch_name` and  `zenci/tests/php53/pr-PR_NUMBER`
- **REPLACE_WITH_INIT_SCRIPT_PATH** - path to script that will init your software to be ready for test. Like install **drupal** or restore from mysqldump and startup some extra services.
- **REPLACE_WITH_TEST_SCRIPT_PATH_1** to **_N** - you can define as many as you need test scripts. All of them will be executed one by one.
- **dir** - I already provided best to fit variable, but you can use your own. It's where your repository will be cloned to and environment variable **ZENCI_DEPLOY_DIR** will be pointed to.
- You also can use **ENV_VARS** exactly the same way how we described it for deploy stage. *see **Deploy** docs*
- **REPLACE_WITH_BOX_NAME**, it is a box name. 

#### 2. Boxes

Right now we have next predefined boxes:

Name | vCPU | Memory | OS | Drive | Extra 
------- | ------- | ------- | ------- | ------- | ------- | 
**dual-leam-php53** | 2 | 1.8GB | CentOS6 | 10GB | mod_php 5.3.x with xcache
**dual-leam-php70** | 2 | 1.8GB | CentOS6 | 10GB | mod_php 7.0.x with opcache
**quadro-leam-php53** | 4 | 3.6GB | CentOS6 | 10GB | mod_php 5.3.x with xcache
**quadro-leam-php70** | 4 | 3.6GB | CentOS6 | 10GB | mod_php 7.0.x with opcache
**octo-leam-php53** | 8 | 7.2GB | CentOS6 | 10GB | mod_php 5.3.x with xcache
**octo-leam-php70**  | 8 | 7.2GB | CentOS6 | 10GB | mod_php 7.0.x with opcache

- **This boxes are preemptible.**  There is a chance that your tests could be interrupted. In this case, tests will be restarted as soon as possible.
- **Permissions** - **init** and **tests** scripts run under user **test**. However you can run **sudo some_root_required_cmd** with no password. 
- **MySQL** -  user **test** , database **test** with no password. 
- **DOCROOT** -  located in **/home/test/www**. http://localhost pointed to this directory.

#### 3. Custom

Boxes can be custom. **If you have your own OS image - [contact us](https://zen.ci/contact)**.

Instead of giving a box predefined name, you can control it via defining next values:
```yaml
box: 
  machine: 'MACHINE_NAME'
  image: 'IMAGE_NAME'
  preemptible: TRUE_OR_FALSE
  disk:
    type: HDD_TYPE
    size: HDD_SIZE
```

- **MACHINE_NAME** - dual (2 vCPU), quadro (4 vCPU) or octo (8 vCPU)
- **HDD_TYPE** - hdd or ssd.
- **HDD_SIZE** - size in GB. Start from 10GB.
- **IMAGE_NAME** - one of available images. See bellow.

#### 4. Images

Name | OS | Details
------- | ------- | -------
leam-php53 | CentOS6 | Nginx Apache Mysql mod_php 5.3.x with xcache
leam-php70 | CentOS6 | Nginx Apache Mysql mod_php 7.0.x with opcache

We are working on adding more prebuilt images.

If you need a custom build (OS, software and configuration) - [contact us](https://zen.ci/contact).
Drupal 7.x tests

# Getting started

*PHP.OF.BY #19 example*

**ZenCI** is automation tool that helps you to deploy and test your software. 

It works only with **GitHub** and inherits many UI& UX behaviours from **GitHub** to minimize adaptation period.

#### Setting up **ZenCI**

Setting up **ZenCI** require next steps:
- Sign up with GitHub Account - *it will give **ZenCI** permission to access **GitHub** on your behalf*
- Enable repository on **ZenCI** website - *it will setup web hook for specified repository*
- upload **.zenci.yml** file to repository - *it is deploy and test settings for repository*

#### Permissions

**ZenCI** inherit **GitHub** permissions. 

Only users with **admin** permissions can enable repository.

If repository is **private**, it will be visible to users who has at least **read** permissions to this repository.

#### Security

**ZenCI** does not store your code in any way. We use **public_key** to access deploy or test target via **SSH** and only then use `git clone` to download code. 

For **private** repositories we use user's **token** to clone repository.

If you use our **test boxes**, please be aware that we deploy code on temporary created **test box**, run tests and then completely destroy **test box**. We never **reuse** the same test box twice.

If you need even more **privacy**, you can setup your own **test box** and configure **.zenci.yml** file to run tests on your own machine. 

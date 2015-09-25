Seek Beer Cartel APP
====================


Things still to do
-----------------

##### Things to Fix
1. remove photo option
2. date selects through out site


##### Things to Add
1. Settings DB
	* Change background
 	* change number of pics in carousel
2. show members of beer club on meeting index



Environment Variables 
---------------------

### Development Environment

\config\environment\development.rb
```
ENV["SMTP_FROM"]
ENV["SMTP"]
ENV["SMTP_PORT"]
ENV["SMTP_USERNAME"]
ENV["SMTP_PASSWORD"]
```

### Production Environment

\config\environment\production.rb
```
ENV["SMTP_FROM"]
ENV["SMTP"]
ENV["SMTP_PORT"]
ENV["SMTP_USERNAME"]
ENV["SMTP_PASSWORD"]
```

### Photo Uploader

\config\initializers\carrier_wave.rb
```
ENV['S3_ACCESS_KEY']
ENV['S3_SECRET_KEY']
ENV['S3_BUCKET']
```

### Datebase
\config\database.yml
```
ENV['sql_name']
ENV['sql_username']
ENV['sql_password']
ENV['sql_host']
```

### Secret tokens
```
ENV["SECRET_KEY_BASE"]
```
to create a secret key run 
```
rake secret
```



Deployment Setup
----------------

config/deploy/production.rb
```
server 'replace with address'
user: 'user name'
```

config/deploy.rb
```
set :application, "beer"
set :repo_url, "git@github.com:wonderphil/beer-cartel.git"
set :deploy_to, "/home/svc_www/apps/#{fetch(:application)}"
set :deploy_user, "svc_www"
set :rbenv_ruby, "2.2.2"
```

config/nginx.conf
```
server unix:/tmp/unicorn.beer.sock fail_timeout=0;

server_name www.beer.pdavies.com.au;
return 301 $scheme://beer.phildavies.com.au$request_uri;

server_name beer.pdavies.com.au;
root /home/svc_app/apps/beer/releases/current/public;
```

config/unicorn.rb
```
root = "/home/svc_www/apps/beer/current"
listen "/tmp/unicorn.beer.sock"
```

config/unicorn_init.sh
```
APP_ROOT=/home/ubuntu/apps/beer/current
AS_USER=ubuntu
```

1. Once all the above config is setup, commit and push changes to git
2. Must have a working connection to git from the server
3. Must have Env vars setup on server
4. Must have DB setup with black database if first deployment
5. From local run 
	1. cap production setup:upload_yml
	2. cap production setup:symlink_config
	3. cap production deploy
	4. just for good luck run cap production deploy:restart









set :stage, :production
set :rails_env, :production

server 'beer.cloud.seek.com.au', user: 'ubuntu', port: 22, roles: %w{web app db}, primary: true
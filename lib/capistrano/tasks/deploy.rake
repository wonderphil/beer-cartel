namespace :deploy do

  desc "Makes sure local git is in sync with remote."
  task :check_revision do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end

  %w[start stop restart].each do |command|
    desc "#{command} Unicorn server."
    task command do
      on roles(:app) do
        execute "/etc/init.d/unicorn_#{fetch(:application)} #{command}"
      end
    end
  end

  desc "restart nginx."
  task :restart_nginx do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute "sudo service nginx restart"
        end
      end
    end
  end  


  desc "Re-index the Elastic Search."
  task :index_es do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "searchkick:reindex CLASS=Beer"
        end
      end
    end
  end

  before :deploy, "deploy:check_revision"
  after :deploy, "deploy:restart"
  after :rollback, "deploy:restart"

end
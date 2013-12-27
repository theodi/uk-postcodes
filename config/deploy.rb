set :application, 'uk-postcodes'
set :repo_url, 'git@github.com:theodi/uk-postcodes.git'
set :branch, 'master'

set :deploy_to, '/var/www/uk-postcodes'
set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

# 
# namespace :foreman do
#   desc "Export the Procfile to Ubuntu's upstart scripts"
#   task :export, :roles => :app do
#     run "cd /var/uk-postcodes && sudo bundle exec foreman export upstart /etc/init -a uk-postcodes -u uk-postcodes -l /var/payrollapp/log"
#   end
#   
#   desc "Start the application services"
#   task :start, :roles => :app do
#     sudo "start uk-postcodes"
#   end
# 
#   desc "Stop the application services"
#   task :stop, :roles => :app do
#     sudo "stop uk-postcodes"
#   end
# 
#   desc "Restart the application services"
#   task :restart, :roles => :app do
#     run "sudo start uk-postcodes || sudo restart uk-postcodes"
#   end
# end
# 
# after "deploy:update", "foreman:export"
# after "deploy:update", "foreman:restart"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end

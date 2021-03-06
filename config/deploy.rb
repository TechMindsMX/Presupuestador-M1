# config valid only for current version of Capistrano
lock "3.7.2"

set :application, "presupuestador-m1"
set :repo_url, "git@github.com:TechMindsMX/Presupuestador-M1.git"
set :rbenv_ruby, '2.4.0'

# set :puma_init_active_record, true
set :puma_user, fetch(:user)
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
set :linked_files, fetch(:linked_files, []).push('config/secrets.yml')

Rake::Task["deploy:assets:precompile"].clear_actions
Rake::Task["deploy:assets:backup_manifest"].clear_actions

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart

end

namespace :bower do

  desc "Symlink shared components to current release"
  task :symlink do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/vendor/assets/third-party"
      execute "ln -nfs #{shared_path}/vendor/assets/third-party #{release_path}/vendor/assets/third-party"
    end
  end

  desc "Install the current Bower environment"
  task :install do
    on roles(:app) do
      execute "cd #{release_path} && ~/.nodenv/versions/7.5.0/bin/node ~/.nodenv/versions/7.5.0/bin/npm install"
      execute "cd #{release_path} && ~/.nodenv/versions/7.5.0/bin/node node_modules/bower/bin/bower install"
    end
  end

  desc "Uninstalls local extraneous packages"
  task :prune do
    on roles(:app) do
      execute "cd #{release_path} && ~/.nodenv/versions/7.5.0/bin/node node_modules/bower/bin/bower prune"
    end
  end

end

before "deploy:assets:precompile", "bower:install"
before "bower:install", "bower:symlink"
after  "bower:install", "bower:prune"

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma

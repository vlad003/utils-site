set :application, "utils"
set :deploy_to, "/var/www/utils"

set :repository,  "https://github.com/vlad003/utils-site.git"
set :scm, :git
set :branch, "master"

role :web, "ec2.avacariu.me"                          # Your HTTP server, Apache/etc
role :app, "ec2.avacariu.me"                          # This may be the same as your `Web` server

set :user, "ubuntu"
set :use_sudo, false
set :webserver_user, "www-data"
default_run_options[:pty] = true

set :permission_method, :acl
set :use_set_permissions, true

namespace :deploy do
    task :reload_uwsgi do
        run "touch #{deploy_to}/UWSGI_RELOAD"
    end
end

namespace :utils do
    task :run_puppet do
        run "sudo puppet agent -t; true"
    end
end

after "deploy", "deploy:reload_uwsgi"
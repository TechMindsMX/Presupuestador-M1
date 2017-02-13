set :stage, :qa
set :puma_bind, %w(tcp://0.0.0.0:3000)
set :branch, 'master'
set :deploy_to, "/var/www/#{fetch(:application)}/qa"

server 'presupuestador-qa.modulusuno.com', user: 'ec2-user', roles: %w{app web}

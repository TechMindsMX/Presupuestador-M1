set :stage, :stage
set :puma_bind, %w(tcp://0.0.0.0:3001)
set :branch, 'stage'
set :deploy_to, "/var/www/#{fetch(:application)}/stage"

server 'presupuestador-qa.modulusuno.com', user: 'ec2-user', roles: %w{app web}

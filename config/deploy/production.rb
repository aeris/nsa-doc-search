set :stage, :production
server 'nsa.lqdn.fr', user: :root, roles: %w(web app db)

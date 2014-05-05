set :stage, :staging
set :rails_env, :production

set :scm, :rsync
set :rsync_scm, :git
set :rsync_options, %w(--archive --acls --xattrs)

server 'nsa.imirhil.fr', user: 'root', roles: %w(web app db)

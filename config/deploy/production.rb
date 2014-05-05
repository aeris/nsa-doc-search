set :stage, :production
server 'nsa.lqdn.fr', user: :root, roles: %w(web app db)

set :scm, :rsync
set :rsync_scm, :git
set :rsync_options, %w(--archive --acls --xattrs)

# set :scm, :git
# set :repo_url, 'git@github.com:aeris/nsa-doc-search.git'

include_recipe 'apt'

# Git
package 'git-core'

# Mercurial
package 'mercurial'

# Mercurial-git
%w(python-pip python-dev build-essential).each do |p|
  package p
end
execute 'pip install hg-git'

# Generate ssh key for user with provided username.
# Source: https://gist.github.com/3dd13/788178#file-chef-ssh-definitions-generate_ssh_keys-rb
# TODO: Make a resource with this function
def generate_ssh_key(username)
  Chef::Log.debug("generate ssh skys for #{username}.")
  execute "generate ssh keys for #{username}." do
    user username
    creates "/home/#{username}/.ssh/id_rsa.pub"
    command "ssh-keygen -t rsa -q -f /home/#{username}/.ssh/id_rsa -P \"\""
  end
end

teamcity_user = 'teamcity'
generate_ssh_key(teamcity_user)

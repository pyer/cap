
  # The hash of hosts defined for each role
  # Each entry in the hash points to an array of host that belong in that role.
  $hosts = Hash.new

  # Define a new role and its associated hosts.
  # Usage:
  #   role :db,  "db1.example.com", "db2.example.com"
  #   role :app, "app1.example.com", "app2.example.com"
  #
  def role(which, *args)
    which = which.to_sym

    # The roles Hash is defined so that unrecognized keys always auto-initialize
    # to a new Role instance (see the assignment in the initialize_with_roles method,
    # above). However, we explicitly assign here so that role declarations will
    # vivify the role object even if there are no host arguments. (Otherwise,
    # role(:app) won't actually instantiate a Role object for :app.)
    $hosts[which] ||= []
    args.each { |host| $hosts[which] << host }
  end

  # An alternative way to associate hosts with roles. If you have a host
  # that participates in multiple roles, this can be a DRYer way to describe
  # An alternative way to associate hosts with roles. If you have a host
  # that participates in multiple roles, this can be a DRYer way to describe
  # the relationships. Pass the host definition as the first parameter, and
  # the roles as the remaining parameters:
  #
  #   host "master.example.com", :web, :app
  def host(host, *roles)
    raise ArgumentError, "host #{host} has no role" if roles.empty?
    roles.each { |name| role(name, host) }
  end

  $header = true
  def header(state)
    $header = false if state == :off
  end

load './config/nodes'

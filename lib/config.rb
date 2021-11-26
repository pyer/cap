
  # The hash of hosts defined for each group
  # Each entry in the hash points to an array of host that belong in that group.
  $hosts = Hash.new

  # Define a new group and its associated hosts.
  # Usage:
  #   group :db,  "db1.example.com", "db2.example.com"
  #   group :app, "app1.example.com", "app2.example.com"
  #
  def group(which, *args)
    which = which.to_sym

    # The groups Hash is defined so that unrecognized keys always auto-initialize
    # to a new Group instance (see the assignment in the initialize_with_groups method,
    # above). However, we explicitly assign here so that group declarations will
    # vivify the group object even if there are no host arguments. (Otherwise,
    # group(:app) won't actually instantiate a Group object for :app.)
    $hosts[which] ||= []
    args.each { |host| $hosts[which] << host }
  end

  # An alternative way to associate hosts with groups. If you have a host
  # that participates in multiple groups, this can be a DRYer way to describe
  # An alternative way to associate hosts with groups. If you have a host
  # that participates in multiple groups, this can be a DRYer way to describe
  # the relationships. Pass the host definition as the first parameter, and
  # the groups as the remaining parameters:
  #
  #   host "master.example.com", :web, :app
  def host(host, *groups)
    raise ArgumentError, "host #{host} has no group" if groups.empty?
    groups.each { |name| group(name, host) }
  end

  $header = true
  def header(state)
    $header = false if state == :off
  end

load './config/nodes'

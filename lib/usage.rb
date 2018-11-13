# encoding: UTF-8
#
def usage
  puts "Usage: #{$PROGRAM_NAME} role command"
  puts '  role is defined by config/nodes'
  puts '  command is launched on hosts owning the role'
  puts ''
  exit
end

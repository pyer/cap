# encoding: UTF-8
#
def usage
  puts "Usage: #{$PROGRAM_NAME} group|host command"
  puts "  groups and hosts are defined in './config/nodes'"
  puts "  command is launched on hosts belonging to the group"
  puts
  exit
end

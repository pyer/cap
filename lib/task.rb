# encoding: UTF-8
#
require 'net/ssh'
require 'color'

class Task < Thread

  @@count = 0

  def self.running
    @@count > 0
  end

  def initialize(host, command)
    @@count += 1
    @logs = ''
    @header = ''
    @start_at = Time.now
    @end_at = 0
    @wip = true
    conf = Net::SSH::Config.for(host)
    user = conf[:user]
    if conf.nil? || user.nil?
      log_error "host #{host} is unknown"
    else
      @header = "==> ssh #{user}@#{host} #{command}"
      puts @header
      super {launch(user, host, command)}
    end
  end
 
  def log_error(msg)
    puts Color::RED+"ERROR: #{msg}"+Color::DEFAULT
    @@count -= 1
  end

  def launch(user, host, command)
    begin
      Net::SSH.start(host, user) do |ssh|
        block = Proc.new do |ch, type, data|
          @logs += data
        end
        channel = ssh.exec command do |ch, type, data|
          @logs += data
        end
        channel.wait
      end
    rescue SocketError
      log_error "host #{host} connection failed"
    rescue Net::SSH::AuthenticationFailed
      log_error "user #{user} authentication failed"
    end
    @end_at = Time.now
    @@count -= 1
  end

  def progress
    @wip = !@wip && status
    @wip ? '. ' : ': '
  end

  def report
    print Color::YELLOW
    puts "#{@header}   (Duration: #{format("%.1f",(@end_at - @start_at))} s)"
    print Color::DEFAULT
    puts @logs
  end

end

# Set the current app's path for later reference. Rails.root isn't available at
# this point, so we have to point up a directory.
app_path = ENV['STACK_PATH'] || File.expand_path(File.dirname(__FILE__) + '/..')

worker_processes Integer(ENV['WEB_CONCURRENCY'] || 2)

working_directory app_path

listen app_path + '/tmp/web_server.sock', backlog: 64

timeout 30

pid 'tmp/web_server.pid'

stderr_path app_path + '/log/unicorn.stderr.log'
stdout_path app_path + '/log/unicorn.stdout.log'

preload_app true
GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)

check_client_connection false

before_fork do |server, worker|
  old_pid = 'tmp/web_server.pid.oldbin'
  if File.exist?(old_pid) && (server.pid != old_pid)
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end

  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)

  Que.mode = :async
end

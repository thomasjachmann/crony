require "rack"
require "rufus/scheduler"

# start http server in background thread
server = Rack::Server.new(
  :config => File.expand_path("../config.ru", __FILE__),
  :Port   => ENV["PORT"]
)
server_thread = Thread.new { server.start }

# start scheduler in foreground
scheduler = Rufus::Scheduler.new
Dir[File.expand_path "../cron.d/*", __FILE__].each do |cron|
  scheduler.instance_eval IO.read(cron)
end
scheduler.join

# stop http server
server.stop
server_thread.join

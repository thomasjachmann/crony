require "rack"
require "rufus/scheduler"

$stdout.sync = true

puts "starting http server on port #{ENV["PORT"]} in background thread"
server = Rack::Server.new(
  :config => File.expand_path("../config.ru", __FILE__),
  :Port   => ENV["PORT"]
)
server_thread = Thread.new { server.start }

puts "starting scheduler in foreground"
scheduler = Rufus::Scheduler.new
Dir[File.expand_path "../cron.d/*", __FILE__].each do |cron|
  scheduler.instance_eval IO.read(cron)
end
puts "doing my work"
scheduler.join

puts "stopping http server"
server.stop
server_thread.join

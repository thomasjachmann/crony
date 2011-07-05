$:.unshift File.expand_path("../lib", __FILE__)

require "rufus/scheduler"

scheduler = Rufus::Scheduler.start_new

Dir[File.expand_path "../cron.d/*", __FILE__].each do |cron|
  scheduler.instance_eval IO.read(cron)
end

scheduler.join

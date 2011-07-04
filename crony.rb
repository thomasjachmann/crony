require "rufus/scheduler"

scheduler = Rufus::Scheduler.start_new

scheduler.every "2s" do
  puts "done waiting... ok, I'll wait another two seconds"
end

puts "crony started"

scheduler.join

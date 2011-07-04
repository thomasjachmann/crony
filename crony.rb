require "rufus/scheduler"

require "uri"
require "net/http"

scheduler = Rufus::Scheduler.start_new

scheduler.every "2s" do
  url = "http://staging.kickateure.de/"
  Net::HTTP.get_response(URI.parse(url).host, URI.parse(url).path)
end

scheduler.join

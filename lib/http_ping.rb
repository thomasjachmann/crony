require "uri"
require "net/http"

module HttpPing

  def self.ping(url)
    uri = URI.parse(url)
    Net::HTTP.get_response(uri.host, uri.path)
  end

end

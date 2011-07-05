use Rack::Static, :urls => {"/" => "index.html"}, :root => "public"
run Rack::File.new("public")

use Rack::Static, :root => "public", :index => "index.html"
run Rack::File.new("public")

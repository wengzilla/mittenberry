desc "pings my domain every 10 minutes"
task :ping do
  require 'net/http'
  require 'uri'
  Net::HTTP.get URI("http://mittenberry.herokuapp.com")
end
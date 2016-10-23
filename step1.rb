require 'uri'
require 'net/http'
require 'json'

dict = {'token' => '57bbfceb05c5d034b1be3564c22c8c51', 'github' => 'https://github.com/asvnpr/code2040.git'}
json_headers = {"Content-Type" => "application/json",
                "Accept" => "application/json"}

uri = URI.parse('http://challenge.code2040.org/api/register')
http = Net::HTTP.new(uri.host, uri.port)

response = http.post(uri.path, dict.to_json, json_headers)
puts "response was: #{response.body}\nwith status code: #{response.code}"

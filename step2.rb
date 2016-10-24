###post a JSON to code2040, get a string from response, reverse the string and send it back to code2040 for validation
require 'uri'
require 'net/http'
require 'json'

#setup URI and http
uri = URI.parse('http://challenge.code2040.org/api/reverse')
http = Net::HTTP.new(uri.host, uri.port)

#initialize JSON
post = {"token" => "57bbfceb05c5d034b1be3564c22c8c51"}
json_headers = {"Content-Type" => "application/json","Accept" => "application/json"}

#send JSON to URI and get string to reverse
string = http.post(uri.path, post.to_json, json_headers)

#change URI and http for validation endpoint
uri = URI.parse('http://challenge.code2040.org/api/reverse/validate')
http = Net::HTTP.new(uri.host,uri.port)

rev = string.body.to_str.reverse
answer = {"token" => "57bbfceb05c5d034b1be3564c22c8c51","string" => rev}

#send JSON with reversed string and capture response
response = http.post(uri.path, answer.to_json, json_headers)

#check response from http post
puts "response was: #{response.body}\nwith status code: #{response.code}"

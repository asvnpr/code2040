###post a JSON to code2040, get a string from response, reverse the string and send it back to them
require 'uri'
require 'net/http'
require 'json'

#setup URI and http
uri = URI.parse('http://challenge.code2040.org/api/haystack')
http = Net::HTTP.new(uri.host, uri.port)

#initialize JSON
post = {"token" => "57bbfceb05c5d034b1be3564c22c8c51"}
json_headers = {"Content-Type" => "application/json","Accept" => "application/json"}

#send JSON to URI and get JSON with needle string and haystack string array
nh_json = http.post(uri.path, post.to_json, json_headers)

#change URI and http for validation endpoint
uri = URI.parse('http://challenge.code2040.org/api/haystack/validate')
http = Net::HTTP.new(uri.host,uri.port)

#get needle and haystack from nh_json
needle = JSON.parse(nh_json.body)["needle"]
haystack = JSON.parse(nh_json.body)["haystack"]
# get the index where needle string is in the haystack array 
needle_index = haystack.index(needle).to_i

answer = {"token" => "57bbfceb05c5d034b1be3564c22c8c51","needle" => "#{needle_index}"}
response = http.post(uri.path, answer.to_json, json_headers)

#check response from http post
puts "response was: #{response.body}\nwith status code: #{response.code}\nneedle is: #{JSON.parse(nh_json.body)["needle"]}\nhaystack is: #{JSON.parse(nh_json.body)["haystack"]}\nneedle index is #{needle_index}"

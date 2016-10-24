###send post to code2040, reveive JSON with datestamp in ISO8601 format and interval (number of seconds), return datestamp + interval in appropriate format to code2040
require 'uri'
require 'net/http'
require 'json'
require 'time'

#setup URI and http
uri = URI.parse('http://challenge.code2040.org/api/dating')
http = Net::HTTP.new(uri.host, uri.port)

#initialize JSON
post = {"token" => "57bbfceb05c5d034b1be3564c22c8c51"}
json_headers = {"Content-Type" => "application/json","Accept" => "application/json"}

#get response with datestamp and interval
stamp_and_interval = http.post(uri.path, post.to_json, json_headers)

#change URI and http for validation endpoint
uri = URI.parse('http://challenge.code2040.org/api/dating/validate')
http = Net::HTTP.new(uri.host,uri.port)

#get prefix datestamp and interval strings from post response
datestamp = JSON.parse(stamp_and_interval.body)["datestamp"]
interval = JSON.parse(stamp_and_interval.body)["interval"]

#convert datestamp string to object, add seconds, and specify iso8601 format
datestamp_add = (Time.parse(datestamp) + interval.to_i).iso8601



#initialize correct answer dictionary and send to code 2040
answer = {"token" => "57bbfceb05c5d034b1be3564c22c8c51","datestamp" => datestamp_add}
response = http.post(uri.path, answer.to_json, json_headers)

#check response from http post
puts "response was: #{response.body}\nwith status code: #{response.code}\ndatestamp is: #{datestamp}\ninterval is: #{interval}\nchanged datestamp is: #{datestamp_add}"

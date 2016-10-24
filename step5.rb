###send post to code2040, reveive prefix string and array of string. return array with strings without the prefix
require 'uri'
require 'net/http'
require 'json'

#setup URI and http
uri = URI.parse('http://challenge.code2040.org/api/dating')
http = Net::HTTP.new(uri.host, uri.port)

#initialize JSON
post = {"token" => "57bbfceb05c5d034b1be3564c22c8c51"}
json_headers = {"Content-Type" => "application/json","Accept" => "application/json"}

#get response with prefix and array 
stamp_and_interval = http.post(uri.path, post.to_json, json_headers)

#change URI and http for validation endpoint
uri = URI.parse('http://challenge.code2040.org/api/prefix/validate')
http = Net::HTTP.new(uri.host,uri.port)

#get prefix string and array of strings from post response
datestamp = JSON.parse(stamp_and_interval.body)["datestamp"]
interval = JSON.parse(stamp_and_interval.body)["interval"]

puts "datestamp: #{datestamp.split(':')}"

#initialize correct answer dictionary and send to code 2040
#answer = {"token" => "57bbfceb05c5d034b1be3564c22c8c51","array" => array}
#response = http.post(uri.path, answer.to_json, json_headers)

#check response from http post
#puts "response was: #{response.body}\nwith status code: #{response.code}\nprefix is: #{prefix}\narray is: #{array}\nnon-prefix strings are: #{array}"

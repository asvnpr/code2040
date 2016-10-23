###send post to code2040, reveive prefix string and array of string. return array with strings without the prefix
require 'uri'
require 'net/http'
require 'json'

#setup URI and http
uri = URI.parse('http://challenge.code2040.org/api/prefix')
http = Net::HTTP.new(uri.host, uri.port)

#initialize JSON
post = {"token" => "57bbfceb05c5d034b1be3564c22c8c51"}
json_headers = {"Content-Type" => "application/json","Accept" => "application/json"}

#get response with prefix and array 
prefix_and_array = http.post(uri.path, post.to_json, json_headers)

#change URI and http for validation endpoint
uri = URI.parse('http://challenge.code2040.org/api/prefix/validate')
http = Net::HTTP.new(uri.host,uri.port)

#get prefix string and array of strings from post response
prefix = JSON.parse(prefix_and_array.body)["prefix"]
array = JSON.parse(prefix_and_array.body)["array"].to_a

#iterate through array and remove values that contain the prefix
for s in array
  if(s[0,prefix.length] == prefix)
    array = array - [s]
  end
end

#initialize correct answer dictionary and send to code 2040
answer = {"token" => "57bbfceb05c5d034b1be3564c22c8c51","array" => array}
response = http.post(uri.path, answer.to_json, json_headers)

#check response from http post
puts "response was: #{response.body}\nwith status code: #{response.code}\nprefix is: #{prefix}\narray is: #{array}\nnon-prefix strings are: #{array}"

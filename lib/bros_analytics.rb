require 'elasticsearch'
require_relative 'bros-analytics/message.rb'

client = Elasticsearch::Client.new(
  log: true,
  url: ENV["ELASTIC_URL"],
  user: ENV["ELASTIC_USER"],
  password: ENV["ELASTIC_PASSWORD"]
)

count = 0

puts "Opening #{ENV["FACEBOOK_MESSAGES"]}"
html = Nokogiri::HTML(open(ENV["FACEBOOK_MESSAGES"]))

html.css('.message').each do |msg|
  message = Message.new(msg)
  count += 1
  puts message.to_json
  client.index  index: 'messages', type: 'message', id: count, body: message.to_json
end

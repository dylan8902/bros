require 'elasticsearch'
require_relative 'bros-analytics/message.rb'

client = Elasticsearch::Client.new(
  log: true,
  url: ENV["ELASTIC_URL"],
  user: ENV["ELASTIC_USER"],
  password: ENV["ELASTIC_PASSWORD"]
)

id = 0
messages = []

puts "Opening #{ENV["FACEBOOK_MESSAGES"]}"
html = Nokogiri::HTML(open(ENV["FACEBOOK_MESSAGES"]))

html.css('.message').each do |msg|
  id += 1
  message = Message.new(msg)
  messages << { index: { _index: 'messages', _type: 'message', _id: id, data: message.to_map } }

  # Batch up to send
  if messages.count == 1000
    client.bulk body: messages
    messages = []
  end
end

# Send the final batch
client.bulk body: messages

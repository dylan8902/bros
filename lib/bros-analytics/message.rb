#require 'rubygems'
require 'nokogiri'

class Message

  attr_reader :author, :timestap, :text, :image
  attr_writer :author, :timestap, :text, :image

  def initialize msg
    @author = msg.css('.user').first.text
    @timestamp = msg.css('.meta').first.text
    @text = msg.next_element.text
    unless msg.next_element.next_element.nil?
      if msg.next_element.next_element.node_name == 'p'
        @image = msg.next_element.next_element.child.attribute('src').value
      end
    end
    puts self.inspect
  end

  def self.parse filename
    puts "Opening #{filename}"
    html = Nokogiri::HTML(open(filename))
    html.css('.message').each do |msg|
      Message.new(msg)
    end
  end

end

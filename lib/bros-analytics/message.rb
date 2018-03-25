require 'nokogiri'
require 'json'

class Message

  attr_reader :author, :timestap, :text, :image
  attr_writer :author, :timestap, :text, :image


  def initialize msg
    @author = msg.css('.user').first.text
    @timestamp = Time.parse(msg.css('.meta').first.text)
    @text = msg.next_element.text
    unless msg.next_element.next_element.nil?
      if msg.next_element.next_element.node_name == 'p'
        paragraph = msg.next_element.next_element
        if paragraph.child and paragraph.child.attribute('src')
          @image = paragraph.child.attribute('src').value
        end
      end
    end
  end


  def to_json
    return { author: @author, timestamp: @timestamp.to_i, text: @text, image: @image }.to_json
  end


  def to_s
    return "Message: #{self.to_json}"
  end


end

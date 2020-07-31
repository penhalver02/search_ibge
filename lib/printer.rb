# frozen_string_literal: true

# print the list of ufs
class Printer
  attr_reader :data, :title

  def initialize(data, title)
    @data = data
    @title = title
  end

  def print
    puts title
    data.each do |row|
      puts row
      puts '------------------------------------------'
    end
  end
end

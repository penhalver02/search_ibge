# frozen_string_literal: true

# print the list of ufs
class Printer
  attr_reader :presenter

  def initialize(presenter)
    @presenter = presenter
  end

  def print
    puts presenter.title
    presenter.table.each do |row|
      puts row
      puts '------------------------------------------'
    end
  end
end

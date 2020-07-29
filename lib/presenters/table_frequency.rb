# frozen_string_literal: true

module Presenters
  # print a table with names
  class TableFrequency
    attr_reader :title, :names

    def initialize(title, names)
      @title = title
      @names = names
    end

    def printf
      puts "#{title} #{names[0].name}"
      print 'periodo'.center(15), "         Frequencia\n"
      print_period
    end

    private

    def print_period
      names.each do |name|
        puts "#{name.period.to_s.center(15)}  |  #{name.frequency.to_s.center(15)}"
      end
    end
  end
end

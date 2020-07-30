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
      names.each do |name|
        puts "#{title} #{name[0].name}"
        print 'periodo'.center(15), "         Frequencia\n"
        print_period(name)
      end
    end

    private

    def print_period(name)
      name.each do |q|
        puts "#{q.period.to_s.center(15)}  |  #{q.frequency.to_s.center(15)}"
      end
    end
  end
end

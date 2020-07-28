# frozen_string_literal: true

module Presenters
  # print a table with names
  class TableCities
    attr_reader :title, :names

    def initialize(title, names)
      @title = title
      @names = names
    end

    def printf
      p title
      print 'Ranking'.center(10), '        Nome'.center(10), "         Frequencia\n"
      names.each do |name|
        puts "#{name.ranking.to_s.center(10)}  |  #{name.name.center(10)}  |  #{name.frequency.to_s.center(10)}"
      end
    end
  end
end

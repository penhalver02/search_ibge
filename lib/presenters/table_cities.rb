# frozen_string_literal: true

module Presenters
  # print a table with names
  class TableCities
    attr_reader :lines

    def initialize(lines)
      @lines = lines
    end

    def table
      table = ['Ranking          Nome         Frequencia']
      lines.each do |line|
        table << "#{line.ranking.to_s.center(10)}  |  #{line.name.center(10)}  |  #{line.frequency.to_s.center(10)}"
      end
      table
    end
  end
end

# frozen_string_literal: true

module Presenters
  # print a table with names
  class TableFrequency
    attr_reader :names

    def initialize(names)
      @names = names
    end

    def table
      names.map do |name|
        table = [name.first.name.to_s, "    periodo           Frequencia\n"]
        table << print_period(name)
      end
    end

    private

    def print_period(name)
      name.map do |q|
        "#{q.period.to_s.center(15)}  |  #{q.frequency.to_s.center(15)}"
      end
    end
  end
end

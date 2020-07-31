# frozen_string_literal: true

module Presenters
  # print a table with names
  class TableFrequency
    attr_reader :names, :title

    def initialize(names, title)
      @names = names
      @title = title
    end

    def table
      names.map do |name|
        table = [name.first.name, "    periodo           Frequencia\n"]
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

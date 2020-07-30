# frozen_string_literal: true

module Presenters
  # print the list of ufs
  class Cities
    attr_reader :cities

    def initialize(cities)
      @cities = cities
    end

    def print
      puts 'lista das cidades'
      cities.each do |cities|
        puts "#{cities.code} - #{cities.name}"
      end
    end
  end
end

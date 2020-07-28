# frozen_string_literal: true

module Presenters
  # print the list of ufs
  class States
    attr_reader :states

    def initialize(states)
      @states = states
    end

    def print
      puts 'lista das UFs'
      states.each do |state|
        puts "#{state.code} - #{state.name}"
      end
    end
  end
end

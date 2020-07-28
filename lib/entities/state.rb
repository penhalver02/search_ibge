# frozen_string_literal: true

module Entities
  # initialize a state entity
  class State
    attr_reader :code, :name, :population
    def initialize(code, name, population)
      @code = code
      @name = name
      @population = population
    end
  end
end

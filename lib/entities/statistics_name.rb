# frozen_string_literal: true

module Entities
  # initialize a statistics name entity
  class StatisticsName
    attr_reader :name, :ranking, :frequency

    def initialize(name, ranking, frequency)
      @name = name
      @ranking = ranking
      @frequency = frequency
    end
  end
end

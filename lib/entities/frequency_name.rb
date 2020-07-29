# frozen_string_literal: true

module Entities
  # initialize a frequency name entity
  class FrequencyName
    attr_reader :name, :period, :frequency

    def initialize(name, period, frequency)
      @name = name
      @period = period
      @frequency = frequency
    end
  end
end

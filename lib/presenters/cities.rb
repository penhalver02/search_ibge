# frozen_string_literal: true

module Presenters
  # print the list of ufs
  class Cities
    attr_reader :lines

    def initialize(lines)
      @lines = lines
    end

    def table
      lines.map do |line|
        "#{line.code} - #{line.name}"
      end
    end
  end
end

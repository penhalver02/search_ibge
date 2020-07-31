# frozen_string_literal: true

module Presenters
  # print the list of ufs
  class Cities
    attr_reader :lines, :title

    def initialize(lines, title)
      @lines = lines
      @title = title
    end

    def table
      lines.map do |line|
        "#{line.code} - #{line.name}"
      end
    end
  end
end

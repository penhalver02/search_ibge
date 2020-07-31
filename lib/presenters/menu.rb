# frozen_string_literal: true

module Presenters
  # print all opcions
  class Menu
    attr_reader :title, :services

    def initialize(services, title)
      @services = services
      @title = title
    end

    def table
      ["#{services::NAME_IN_UF} para fereficar nome por UF",
       "#{services::NAME_IN_CITY} para verificar nome por city",
       "#{services::NAME_IN_THE_TIME} para vereficar nome durante o tempo",
       "#{services::QUIT} para sair",
       'Digite uma das opcoes']
    end
  end
end

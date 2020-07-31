# frozen_string_literal: true

module Presenters
  # print all opcions
  class Menu
    NAME_IN_UF = 1
    NAME_IN_CITY = 2
    NAME_IN_THE_TIME = 3
    QUIT = 4

    def print
      ["#{NAME_IN_UF} para fereficar nome por UF",
       "#{NAME_IN_CITY} para verificar nome por city",
       "#{NAME_IN_THE_TIME} para vereficar nome durante o tempo",
       "#{QUIT} para sair",
       'Digite uma das opcoes']
    end
  end
end

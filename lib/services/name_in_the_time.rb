# frozen_string_literal: true

module Services
  # show the frequency of name along the time
  class NameIntheTime
    def self.get_name_in_the_time(name)
      frequency_of_name = Repositories::Ibge.request_name(name)
      if frequency_of_name.empty?
        puts 'Nome não encontrado'
      else
        presenter = Presenters::TableFrequency.new(frequency_of_name, 'Tabela de frequencia ')
        Printer.new(presenter).print
      end
    end
  end
end

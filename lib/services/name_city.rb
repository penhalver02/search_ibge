# frozen_string_literal: true

module Services
  # this class execute the second option of menu, show the city tables
  class NameCity
    def self.get_city(code)
      if Repositories::Uf.check_city_is_not_valid?(code)
        puts 'Digite um codigo valido'
      else
        print_table(code, 'Tabela de nomes no Cidade')
        print_table(code, 'Tabela de nomes masculinos no Cidade', sexo: 'M')
        print_table(code, 'Tabela de nomes femeninos no Cidade', sexo: 'F')
      end
    end

    def self.list_city(city)
      city = Repositories::Uf.get_city_by_name(city)
      presenter = Presenters::Cities.new(city, 'Cidades encontradas')
      Printer.new(presenter).print
    end

    def self.print_table(code, title, option = {})
      names = Repositories::Ibge.resque_uf(code, option)
      presenter = Presenters::TableCities.new(names, title)
      Printer.new(presenter).print
    end
  end
end

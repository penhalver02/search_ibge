# frozen_string_literal: true

module Services
  # this class execute the first option of menu, show the ufs tables
  class NameUf
    def self.get_uf(code)
      if Repositories::Uf.check_uf_is_not_valid?(code)
        puts 'Digite um codigo valido'
      else
        print_table(code, 'Tabela de nomes no Estado')
        print_table(code, 'Tabela de nomes masculinos no Estado', sexo: 'M')
        print_table(code, 'Tabela de nomes femeninos no Estado', sexo: 'F')
      end
    end

    def self.list_uf
      ufs = Repositories::Uf.list
      presenter = Presenters::States.new(ufs, 'Lista de Ufs')
      Printer.new(presenter).print
    end

    def self.print_table(code, title, option = {})
      names = Repositories::Ibge.resque_uf(code, option)
      presenter = Presenters::TableCities.new(names, title)
      Printer.new(presenter).print
    end
  end
end

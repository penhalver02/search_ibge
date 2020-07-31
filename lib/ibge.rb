# frozen_string_literal: true

require 'faraday'
require 'json'
require 'pry'
require 'sqlite3'
require 'active_support/all'
require_relative 'entities/state'
require_relative 'entities/city'
require_relative 'entities/statistics_name'
require_relative 'entities/frequency_name'
require_relative 'presenters/menu'
require_relative 'repositories/uf'
require_relative 'repositories/ibge'
require_relative 'presenters/states'
require_relative 'presenters/cities'
require_relative 'presenters/table_cities'
require_relative 'presenters/table_frequency'
require_relative 'printer'
require_relative 'available_services'

presenter = Presenters::Menu.new(AvailableServices, 'Menu')
Printer.new(presenter).print
opcion = gets.to_i

while opcion != AvailableServices::QUIT
  if opcion == AvailableServices::NAME_IN_UF
    ufs = Repositories::Uf.list
    presenter = Presenters::States.new(ufs, 'Lista de Ufs')
    Printer.new(presenter).print
    puts 'Digite o codigo'
    code = gets.to_i
    if Repositories::Uf.check_uf_is_not_valid?(code, 'UF')
      puts 'Digite um codigo valido'
    else
      names = Repositories::Ibge.resque_uf(code)
      presenter = Presenters::TableCities.new(names, 'Tabela de nomes no Estado')
      Printer.new(presenter).print
      names = Repositories::Ibge.resque_uf(code, sexo: 'M')
      presenter = Presenters::TableCities.new(names, 'Tabela de nomes masculinos no Estado')
      Printer.new(presenter).print
      names = Repositories::Ibge.resque_uf(code, sexo: 'F')
      presenter = Presenters::TableCities.new(names, 'Tabela de nomes femeninos no Estado')
      Printer.new(presenter).print
    end
  elsif opcion == AvailableServices::NAME_IN_CITY
    puts 'Digite a cidade'
    city = gets.chomp
    city = Repositories::Uf.get_city_by_name(city)
    presenter = Presenters::Cities.new(city, 'Cidades encontradas')
    Printer.new(presenter).print
    puts 'Confirme a cidade digitando o codigo:'
    confirm_city = gets.to_i

    if Repositories::Uf.check_uf_is_not_valid?(confirm_city, 'MU')
      puts 'Digite um codigo valido'
    else
      names = Repositories::Ibge.resque_uf(confirm_city)
      presenter = Presenters::TableCities.new(names, 'Tabela de nomes na Cidade')
      Printer.new(presenter).print
      names = Repositories::Ibge.resque_uf(confirm_city, sexo: 'M')
      presenter = Presenters::TableCities.new(names, 'Tabela de nomes masculinos na Cidade')
      Printer.new(presenter).print
      names = Repositories::Ibge.resque_uf(confirm_city, sexo: 'F')
      presenter = Presenters::TableCities.new(names, 'Tabela de nomes femeninos na Cidade')
      Printer.new(presenter).print
    end

  elsif opcion == AvailableServices::NAME_IN_THE_TIME
    puts 'Digite o nome'
    name = gets.chomp
    frequency_of_name = Repositories::Ibge.request_name(name)
    if frequency_of_name.empty?
      puts 'Nome não encontrado'
    else
      presenter = Presenters::TableFrequency.new(frequency_of_name, 'Tabela de frequencia ')
      Printer.new(presenter).print
    end
  elsif opcion == AvailableServices::QUIT
  end
  presenter = Presenters::Menu.new(AvailableServices, 'Menu')
  Printer.new(presenter).print
  opcion = gets.to_i
end

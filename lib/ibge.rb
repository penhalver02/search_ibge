# frozen_string_literal: true

require 'faraday'
require 'json'
require 'pry'
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

menu_for_print = Presenters::Menu.new.print
Printer.new(menu_for_print, 'Menu').print
opcion = gets.to_i

while opcion != 4
  if opcion == 1
    ufs = Repositories::Uf.list
    ufs_for_print = Presenters::States.new(ufs).table
    Printer.new(ufs_for_print, 'Lista de Ufs').print
    puts 'Digite o codigo'
    code = gets.to_i
    if Repositories::Uf.check_uf_is_not_valid?(code, 'UF')
      puts 'Digite um codigo valido'
    else
      names = Repositories::Ibge.resque_uf(code)
      names_for_print = Presenters::TableCities.new(names).table
      Printer.new(names_for_print, 'Tabela de nomes no Estado').print
      names = Repositories::Ibge.resque_uf(code, sexo: 'M')
      names_for_print = Presenters::TableCities.new(names).table
      Printer.new(names_for_print, 'Tabela de nomes masculinos no Estado').print
      names = Repositories::Ibge.resque_uf(code, sexo: 'F')
      names_for_print = Presenters::TableCities.new(names).table
      Printer.new(names_for_print, 'Tabela de nomes femeninos no Estado').print
    end
  elsif opcion == 2
    puts 'Digite a cidade'
    city = gets.chomp
    city = Repositories::Uf.get_city_by_name(city)
    city_for_print = Presenters::Cities.new(city).table
    Printer.new(city_for_print, 'Cidades encontradas').print
    puts 'Confirme a cidade digitando o codigo:'
    confirm_city = gets.to_i

    if Repositories::Uf.check_uf_is_not_valid?(confirm_city, 'MU')
      puts 'Digite um codigo valido'
    else
      names = Repositories::Ibge.resque_uf(confirm_city)
      names_for_print = Presenters::TableCities.new(names).table
      Printer.new(names_for_print, 'Tabela de nomes na Cidade').print
      names = Repositories::Ibge.resque_uf(confirm_city, sexo: 'M')
      names_for_print = Presenters::TableCities.new(names).table
      Printer.new(names_for_print, 'Tabela de nomes masculinos na Cidade').print
      names = Repositories::Ibge.resque_uf(confirm_city, sexo: 'F')
      names_for_print = Presenters::TableCities.new(names).table
      Printer.new(names_for_print, 'Tabela de nomes femeninos na Cidade').print
    end

  elsif opcion == 3
    puts 'Digite o nome'
    name = gets.chomp
    frequency_of_name = Repositories::Ibge.request_name(name)
    if frequency_of_name.empty?
      puts 'Nome não encontrado'
    else
      names_for_print = Presenters::TableFrequency.new(frequency_of_name).table
      Printer.new(names_for_print, 'Tabela de frequencia ').print
    end
  elsif opcion == 4
  end
  menu_for_print = Presenters::Menu.new.print
  Printer.new(menu_for_print, 'Menu').print
  opcion = gets.to_i
end

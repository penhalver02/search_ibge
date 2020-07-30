# frozen_string_literal: true

require 'faraday'
require 'json'
require 'pry'
require_relative 'entities/state'
require_relative 'entities/statistics_name'
require_relative 'entities/frequency_name'
require_relative 'presenters/menu'
require_relative 'repositories/uf'
require_relative 'repositories/ibge'
require_relative 'presenters/states'
require_relative 'presenters/table_cities'
require_relative 'presenters/table_frequency'

Presenters::Menu.new.print
opcion = gets.to_i

while opcion != 4
  if opcion == 1
    ufs = Repositories::Uf.list
    Presenters::States.new(ufs).print
    puts 'Digite o codigo'
    code = gets.to_i
    if Repositories::Uf.check_uf_is_not_valid?(code)
      puts 'Digite um codigo valido'
    else
      names = Repositories::Ibge.resque_uf(code)
      Presenters::TableCities.new('Tabela de nomes no Estado', names).printf
      names = Repositories::Ibge.resque_uf(code, sexo: 'M')
      Presenters::TableCities.new('Tabela de nomes masculinos no Estado', names).printf
      names = Repositories::Ibge.resque_uf(code, sexo: 'F')
      Presenters::TableCities.new('Tabela de nomes femeninos no Estado', names).printf
    end
  elsif opcion == 2
    puts 'Digite a cidade'
    city = gets.chomp
    city = Repositories::Uf.get_city_by_name(city)
    names = Repositories::Ibge.resque_uf(city.code)
    Presenters::TableCities.new('Tabela de nomes da cidade', names).printf
    names = Repositories::Ibge.resque_uf(city.code, sexo: 'M')
    Presenters::TableCities.new('Tabela de nomes masculinos da Cidade', names).printf
    names = Repositories::Ibge.resque_uf(city.code, sexo: 'F')
    Presenters::TableCities.new('Tabela de nomes femeninos da Cidade', names).printf
  elsif opcion == 3
    puts 'Digite o nome'
    name = gets.chomp
    frequency_of_name = Repositories::Ibge.request_name(name)
    Presenters::TableFrequency.new('Tabela de frequencia do nome:', frequency_of_name).printf
  elsif opcion == 4
  end
  Presenters::Menu.new.print
  opcion = gets.to_i
end

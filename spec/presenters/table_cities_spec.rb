# frozen_string_literal: true

require 'spec_helper'

describe 'Table cities' do
  it 'return of state' do
    data_one = Entities::StatisticsName.new('MARIA', 1, 752_021)
    data_two = Entities::StatisticsName.new('JOSE', 2, 314_276)

    data = [data_one, data_two]

    statistics_name = Presenters::TableCities.new(data, 'titulo')

    expect(statistics_name.table.first).to eq 'Ranking          Nome         Frequencia'
    expect(statistics_name.table[1]).to eq '    1       |    MARIA     |    752021  '
    expect(statistics_name.table[2]).to eq '    2       |     JOSE     |    314276  '
    expect(statistics_name.title).to eq 'titulo'
  end
end

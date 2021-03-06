# frozen_string_literal: true

require 'spec_helper'

describe 'Table cities' do
  it 'return of state' do
    joao_one = Entities::FrequencyName.new('JOAO', '1930[', 60_155)
    joao_two = Entities::FrequencyName.new('JOAO', '[1930,1940[', 141_772)
    maria_one = Entities::FrequencyName.new('MARIA', '1930[', 336_477)
    maria_two = Entities::FrequencyName.new('MARIA', '[1930,1940[', 749_053)

    data = [[joao_one, joao_two], [maria_one, maria_two]]

    statistics_name = Presenters::TableFrequency.new(data, 'titulo')

    expect(statistics_name.table.first[0]).to eq 'JOAO'
    expect(statistics_name.table.first[1]).to eq "    periodo           Frequencia\n"
    expect(statistics_name.table.first[2][0]).to eq '     1930[       |       60155     '
    expect(statistics_name.table.first[2][1]).to eq '  [1930,1940[    |      141772     '
    expect(statistics_name.table.last[0]).to eq 'MARIA'
    expect(statistics_name.table.last[1]).to eq "    periodo           Frequencia\n"
    expect(statistics_name.table.last[2][0]).to eq '     1930[       |      336477     '
    expect(statistics_name.table.last[2][1]).to eq '  [1930,1940[    |      749053     '
    expect(statistics_name.title).to eq 'titulo'
  end
end

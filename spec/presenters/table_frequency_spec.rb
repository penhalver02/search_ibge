# frozen_string_literal: true

require 'spec_helper'

describe 'Table cities' do
  it 'return of state' do
    joao_one = Entities::FrequencyName.new('JOAO', '1930[', 60_155)
    joao_two = Entities::FrequencyName.new('JOAO', '[1930,1940[', 141_772)
    maria_one = Entities::FrequencyName.new('MARIA', '1930[', 336_477)
    maria_two = Entities::FrequencyName.new('MARIA', '[1930,1940[', 749_053)

    data = [[joao_one, joao_two], [maria_one, maria_two]]

    statistics_name = Presenters::TableFrequency.new(data).table

    expect(statistics_name.first[0]).to eq "    periodo           Frequencia\n"
    expect(statistics_name.first[1][0]).to eq '     1930[       |       60155     '
    expect(statistics_name.first[1][1]).to eq '  [1930,1940[    |      141772     '
    expect(statistics_name.last[0]).to eq "    periodo           Frequencia\n"
    expect(statistics_name.last[1][0]).to eq '     1930[       |      336477     '
    expect(statistics_name.last[1][1]).to eq '  [1930,1940[    |      749053     '
  end
end

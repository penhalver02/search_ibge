require 'spec_helper'
require 'entities/statistics_name'

describe 'Statistics name' do
  it 'entities statistics name' do
    statistics_name = Entities::StatisticsName.new('Lucas', 2, 12_000)

    expect(statistics_name.name).to eq 'Lucas'
    expect(statistics_name.ranking).to eq 2
    expect(statistics_name.frequency).to eq 12_000
  end
end

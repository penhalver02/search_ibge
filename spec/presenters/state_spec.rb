# frozen_string_literal: true

require 'spec_helper'

describe 'states' do
  it 'return of state' do
    uf_one = Entities::State.new(11, 'Rondônia', 1_777_225)
    uf_two = Entities::State.new(12, 'Acre', 881_935)

    ufs = [uf_one, uf_two]
    statistics_name = Presenters::States.new(ufs, 'titulo')

    expect(statistics_name.table.first).to eq '11 - Rondônia'
    expect(statistics_name.table.second).to eq '12 - Acre'
    expect(statistics_name.title).to eq 'titulo'
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe 'cities' do
  it 'return of state' do
    uf_one = Entities::City.new(3_304_557, 'Rio de Janeiro (RJ)', 6_718_903)

    ufs = [uf_one]
    statistics_name = Presenters::States.new(ufs).table

    expect(statistics_name.first).to eq '3304557 - Rio de Janeiro (RJ)'
  end
end

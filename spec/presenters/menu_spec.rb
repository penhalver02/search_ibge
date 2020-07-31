# frozen_string_literal: true

require 'spec_helper'

describe 'menu' do
  it 'return of menu' do
    class MockServices
      NAME_IN_UF = 1
      NAME_IN_CITY = 2
      NAME_IN_THE_TIME = 3
      QUIT = 4
    end
    statistics_name = Presenters::Menu.new(MockServices, 'titulo')

    expect(statistics_name.table.first).to eq '1 para fereficar nome por UF'
    expect(statistics_name.table.second).to eq '2 para verificar nome por city'
    expect(statistics_name.title).to eq 'titulo'
  end
end

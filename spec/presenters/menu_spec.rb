# frozen_string_literal: true

require 'spec_helper'

describe 'menu' do
  it 'return of menu' do
    statistics_name = Presenters::Menu.new

    expect(statistics_name.table.first).to eq '1 para fereficar nome por UF'
    expect(statistics_name.table.second).to eq '2 para verificar nome por city'
    expect(statistics_name.title).to eq nil
  end
end

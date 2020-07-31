# frozen_string_literal: true

require 'spec_helper'

describe 'menu' do
  it 'return of menu' do
    statistics_name = Presenters::Menu.new.print

    expect(statistics_name.first).to eq '1 para fereficar nome por UF'
    expect(statistics_name.second).to eq '2 para verificar nome por city'
  end
end

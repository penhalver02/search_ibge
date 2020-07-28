# frozen_string_literal: true

require 'spec_helper'
require 'entities/state'

describe 'State' do
  it 'entities state' do
    state = Entities::State.new(123, 'Rio de Janeiro', 30_000)

    expect(state.name).to eq 'Rio de Janeiro'
    expect(state.code).to eq 123
    expect(state.population).to eq 30_000
  end
end

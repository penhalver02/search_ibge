# frozen_string_literal: true

describe 'request in ibge' do
  it 'list all ufs' do
    ufs =  Repositories::Uf.list

    expect(ufs.first.name).to include('Rondônia')
    expect(ufs.last.name).to include('Distrito Federal')
    expect(ufs.count).to eq(27)
  end

  it 'get the city' do
    city = Repositories::Uf.get_city_by_name('Rio Crespo (RO)')

    expect(city.name).to eq('Rio Crespo (RO)')
    expect(city.code).to eq(1_100_262)
    expect(city.population).to eq(3764)
  end
end

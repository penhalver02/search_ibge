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

describe 'check if uf is valid' do
  it 'it is not valid' do
    uf = Repositories::Uf.check_uf_is_not_valid?(60)

    expect(uf).to eq(true)
  end

  it 'it is valid' do
    uf = Repositories::Uf.check_uf_is_not_valid?(33)

    expect(uf).to eq(false)
  end
end

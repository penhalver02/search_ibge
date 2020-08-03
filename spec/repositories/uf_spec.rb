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

    expect(city.first.name).to eq('Rio Crespo (RO)')
    expect(city.first.code).to eq(1_100_262)
    expect(city.first.population).to eq(3764)
  end

  it 'get the opcions of cities' do
    city = Repositories::Uf.get_city_by_name('Cocal')

    expect(city.count).to eq(6)
    expect(city.first.name).to eq('Cocal (PI)')
    expect(city.last.name).to eq('Cocalzinho de Goiás (GO)')
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

describe 'check if uf is valid' do
  it 'it is not valid' do
    uf = Repositories::Uf.check_city_is_not_valid?(111_111)

    expect(uf).to eq(true)
  end

  it 'it is valid' do
    uf = Repositories::Uf.check_city_is_not_valid?(3_304_557)

    expect(uf).to eq(false)
  end
end

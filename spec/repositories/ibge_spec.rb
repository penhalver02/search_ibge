# frozen_string_literal: true

describe 'request all names' do
  it 'request all names' do
    data = [{ "localidade": '33', "sexo": nil, "res": [{ "nome": 'MARIA', "frequencia": 752_021, "ranking": 1 },
                                                       { "nome": 'JOSE', "frequencia": 314_276, "ranking": 2 }] }]
           .to_json
    url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=33'
    stub_request(:get, url).to_return(status: 200, body: data, headers: {})

    ibge = Repositories::Ibge.resque_uf(33)

    expect(ibge[0].name).to include('MARIA')
    expect(ibge[1].name).to include('JOSE')
  end
end

describe 'request names' do
  it 'request just male names' do
    data = [{ "localidade": '33', "sexo": nil, "res": [{ "nome": 'JOSE', "frequencia": 312_855, "ranking": 1 },
                                                       { "nome": 'JOAO', "frequencia": 207_913, "ranking": 2 }] }]
           .to_json
    url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=33'
    stub_request(:get, url).to_return(status: 200, body: data, headers: {})

    ibge = Repositories::Ibge.resque_uf(33)

    expect(ibge[0].name).to include('JOSE')
    expect(ibge[1].name).to include('JOAO')
  end

  it 'request just male female' do
    data = [{ "localidade": '33', "sexo": nil, "res": [{ "nome": 'MARIA', "frequencia": 749_527, "ranking": 1 },
                                                       { "nome": 'ANA', "frequencia": 296_117, "ranking": 2 }] }]
           .to_json

    url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=33'
    stub_request(:get, url).to_return(status: 200, body: data, headers: {})

    ibge = Repositories::Ibge.resque_uf(33)

    expect(ibge[0].name).to include('MARIA')
    expect(ibge[1].name).to include('ANA')
  end
end

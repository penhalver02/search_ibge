# frozen_string_literal: false

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
    url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=33&sexo=M'
    stub_request(:get, url).to_return(status: 200, body: data, headers: {})

    ibge = Repositories::Ibge.resque_uf(33, sexo: 'M')

    expect(ibge[0].name).to include('JOSE')
    expect(ibge[1].name).to include('JOAO')
  end

  it 'request just male female' do
    data = [{ "localidade": '33', "sexo": nil, "res": [{ "nome": 'MARIA', "frequencia": 749_527, "ranking": 1 },
                                                       { "nome": 'ANA', "frequencia": 296_117, "ranking": 2 }] }]
           .to_json

    url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=33&sexo=F'
    stub_request(:get, url).to_return(status: 200, body: data, headers: {})

    ibge = Repositories::Ibge.resque_uf(33, sexo: 'F')

    expect(ibge[0].name).to include('MARIA')
    expect(ibge[1].name).to include('ANA')
  end
end

describe 'Get frquency of name in time' do
  it 'request one name' do
    data = [{ "nome": 'JOAO', "sexo": nil, "localidade": 'BR', "res": [{ "periodo": '1930[', "frequencia": 60_155 },
                                                                       { "periodo": '[1930,1940[',
                                                                         "frequencia": 141_772 }] }]
           .to_json

    url = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/joao'
    stub_request(:get, url).to_return(status: 200, body: data, headers: {})

    ibge = Repositories::Ibge.request_name('joao')

    expect(ibge[0].name).to eq('JOAO')
    expect(ibge[0].period).to eq('1930[')
    expect(ibge[0].frequency).to eq(60_155)
  end
end

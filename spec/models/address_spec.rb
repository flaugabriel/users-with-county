require 'rails_helper'

RSpec.describe Address, type: :model do
  County.delete_all
  Address.delete_all
  it 'all params is valid' do
    @county = County.create(name: 'Porto Velho', status: 0)
    @address = Address.new(cep: '76810160',
                           complement: 'test banana',
                           street: 'Algodoeiro',
                           neighborhood: 'Eletronorte',
                           city: 'Porto Velho',
                           uf: 'RO',
                           ibge_code: '6513651651',
                           county_id: @county.id
    )

    expect(@address).to be_valid
  end

  it 'vaid when cep is not valid' do
    @county = County.create(name: 'Porto Velho', status: 0)
    @address = Address.new(cep: nil,
                           complement: 'teste bacana',
                           street: 'Algodoeiro',
                           neighborhood: 'Eletronorte',
                           city: 'Porto Velho',
                           uf: 'RO',
                           ibge_code: '6513651651',
                           county_id: @county.id
    )

    expect(@address.valid?).to be_falsey
  end

  it 'when city is not valid' do
    @county = County.create(name: 'Porto Velho', status: 0)
    @address = Address.new(cep: 76_810_160,
                           complement: 'teste bacana',
                           street: 'Algodoeiro',
                           neighborhood: 'Eletronorte',
                           city: nil,
                           uf: 'RO',
                           ibge_code: '6513651651',
                           county_id: @county.id
    )

    expect(@address.valid?).to be_falsey
  end

  it 'when street is not valid' do
    @county = County.create(name: 'Porto Velho', status: 0)
    @address = Address.new(cep: 76_810_160,
                           complement: 'teste bacana',
                           street: nil,
                           neighborhood: 'Eletronorte',
                           city: 'Porto Velho',
                           uf: 'RO',
                           ibge_code: '6513651651',
                           county_id: @county.id
    )

    expect(@address.valid?).to be_falsey
  end


  it 'when not have county' do
    @address = Address.new(cep: 76_810_160,
                           complement: 'teste bacana',
                           street: 'Algodoeiro',
                           neighborhood: 'Eletronorte',
                           city: 'Porto Velho',
                           uf: 'RO',
                           ibge_code: '6513651651',
                           county_id: nil
    )

    expect(@address.valid?).to be_falsey
  end
end

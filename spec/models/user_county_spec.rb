require 'rails_helper'

RSpec.describe UserCounty, type: :model do
  County.delete_all
  User.delete_all

  it 'all accepts' do
    county = County.new(name: 'Porto Velho', status: 1)
    county.save
    user = User.new(name: 'Bruce',
                    email: 'bruce@ironmaiden.com',
                    cpf: '45010589001',
                    cns: '6513516',
                    phone: '69999705594',
                    birth_date: 18.years.ago
    )
    user.save
    user_county = UserCounty.new(user_id: user.id, county_id: county.id)
    expect(user_county).to be_valid
  end

  it 'when not set user' do
    county = County.new(name: 'Porto Velho', status: 1)
    county.save
    user_county = UserCounty.new(user_id: nil, county_id: county.id)
    expect(user_county.valid?).to be_falsey
  end

  it 'when not set county' do
    user = User.new(name: 'Bruce',
                    email: 'bruce@ironmaiden.com',
                    cpf: '45010589001',
                    cns: '6513516',
                    phone: '69999705594',
                    birth_date: 18.years.ago)
    user.save
    user_county = UserCounty.new(user_id: user.id, county_id: nil)
    expect(user_county.valid?).to be_falsey
  end
end

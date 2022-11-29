require 'rails_helper'

RSpec.describe User do
  it "all params is valid" do
    user = User.new(name: 'Bruce',
                    email: 'bruce@ironmaiden.com',
                    cpf: '45010589001',
                    cns: '6513516',
                    phone: '69999705594',
                    birth_date: 18.years.ago
    )

    expect(user).to be_valid
  end

  it "vaid when cpf is not valid" do
    user = User.new(name: 'Bruce',
                    email: 'bruce@ironmaiden.com',
                    cpf: '45010589022',
                    cns: '6513516',
                    phone: '69999705594',
                    birth_date: 18.years.ago
    )

    expect(user.valid?).to be_falsey
  end

  it "when email is not valid" do
    user = User.new(name: 'Bruce',
                    email: 'bruce',
                    cpf: '45010589001',
                    cns: '6513516',
                    phone: '69999705594',
                    birth_date: 18.years.ago
    )

    expect(user.valid?).to be_falsey
  end

  it "when birth day is not valid" do
    user = User.new(name: 'Bruce',
                    email: 'bruce@ironmaiden.com',
                    cpf: '45010589001',
                    cns: '6513516',
                    phone: '69999705594',
                    birth_date: 11.years.ago
    )

    expect(user.valid?).to be_falsey
  end
end

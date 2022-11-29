FactoryBot.define do
  factory(:user) do
    name { Faker::Internet.name }
    email { Faker::Internet.email }
    cpf { Faker::Internet.email }
    phone { Faker::Internet.email }
    birth_date { Faker::Internet.email }
  end
end

FactoryBot.define do
  factory :county do
    name {Faker::FunnyName.name }
    status { false }
  end
end

class UserCounty < ApplicationRecord
  belongs_to :user
  belongs_to :county
  has_many :addresses
end

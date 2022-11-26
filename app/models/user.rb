class User < ApplicationRecord
  has_one :user_county
  has_many :addresses
end

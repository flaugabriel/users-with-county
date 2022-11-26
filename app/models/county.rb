class County < ApplicationRecord
  enum status: %w(off on)


  has_many :user_counties
  has_many :addresses

  validates_uniqueness_of :name
  validates_presence_of :name
  accepts_nested_attributes_for :addresses
end

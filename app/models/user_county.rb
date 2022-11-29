class UserCounty < ApplicationRecord
  belongs_to :user
  belongs_to :county
  has_many :addresses

  validate :uniqueness_of_user
  validates_presence_of :user, :county
  validates :user, :county, presence: { message: 'deve existir' }

  private

  def uniqueness_of_user
    if user.present? && county.present?
      user_county = UserCounty.find_by(user_id: user.id, county_id: county.id).present?
    end

    return unless user_county

    errors.add(:blank, 'Já existe!')
  end
end

class Address < ApplicationRecord
  belongs_to :county

  validates_uniqueness_of :county
  validates_presence_of :street, :street, :city, :uf, :cep

  def cep=(cep)
    if cep.is_a?(String)
      self[:cep] = cep.gsub('-', '').to_i
    end
  end
end

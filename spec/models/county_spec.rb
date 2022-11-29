require 'rails_helper'

RSpec.describe County, type: :model do

  it "all params is valid" do
    county = County.new(name: 'Bruce', status: 1)

    expect(county).to be_valid
  end

  it "all params is not valid" do
    county = County.new(name: nil, status: 1)

    expect(county.valid?).to be_falsey
  end

  it "all params is exist" do
    County.create(name: 'exist', status: 1)
    county = County.new(name: 'exist', status: 1)

    expect(county.valid?).to be_falsey
  end
end

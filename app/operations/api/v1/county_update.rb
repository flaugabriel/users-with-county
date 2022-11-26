class Operations::Api::V1::CountyUpdate < ApplicationOperation
  def process(params = {})
    data = process(params)
    result.assing(:county, data)
  end

  protected

  def process
    data = build_user_county()
  end

  def fetch_user(id)
    User.find(id)
  end
end

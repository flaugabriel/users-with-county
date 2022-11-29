class Operations::Api::V1::CountyCreate < ApplicationOperation
  include ::Om30::Operation::Base

  def process(params)
    data = build(params)
    result.assign(:county, data)
  end

  protected

  def build_county(params)
    County.new(name: params[:name])
  end

  def build(params)
    county = build_county(params)
    if county.save
      build_user_county(params, county)
    else
      result.errors.push(county: county.errors.full_messages.to_sentence)
    end
  end

  def build_user_county(params, county)
    user_county = UserCounty.new(county_id: county.id, user_id: params[:user_id])
    if user_county.save
      result.data.merge(county: user_county)
    else
      result.errors.push('Pessoa já vinculado(a) a este municipio')
    end
  end
end

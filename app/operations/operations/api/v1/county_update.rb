class Operations::Api::V1::CountyUpdate < ApplicationOperation
  include ::Om30::Operation::Base

  def process(params)
    data = build_user_county(params)
    result.assign(:county, data)
  end

  protected

  def build_user_county(params)
    if params[:user_id].present?
      user_county = UserCounty.new(county_id: params[:id], user_id: params[:user_id])
      if user_county.save
        update(params)
        result.data.merge(county: user_county)
      else
        result.errors.push('Pessoa já vinculado(a) a este municipio')
      end
    elsif params[:name].present?
      county = update(params)
      result.data.merge(county: county)
    end
  end

  def update(params)
    fetch_county(params[:id]).update(name: params[:name])
  end

  def fetch_county(id)
    County.find(id)
  end
end

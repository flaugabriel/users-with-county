require "rails_helper"

RSpec.describe Api::V1::CountiesController, type: :controller do
  describe '# GET index' do
    context 'with valid params' do

      before 'build county' do
        create_counties
      end


      subject { get :index, format: :json }

      it { is_expected.to have_http_status(:ok) }

      it 'when have list of county' do
        expect(is_expected.target.stream.body.as_json.present?).to eq(true)
      end

      context 'when not have county' do
        it 'get response and check if exist' do
          UserCounty.delete_all
          User.delete_all
          County.delete_all
          expect(response.body.present?).to eq(false)
        end
      end
    end
  end

  describe 'POST :create' do
    context 'afte post params not ok' do
      before 'clear db' do
        UserCounty.delete_all
        User.delete_all
        County.delete_all
      end

      subject { post :create, params: {county: {name: 'teste', status: 1}} , format: :json }
      it { is_expected.to have_http_status(:unprocessable_entity) }
      it 'when is not create' do
        expect(is_expected.target.stream.body.as_json.present?).to eq(true)
      end
    end
  end

  private

  def create_counties
    30.times do |numero|
      county = County.create(name: "Cidade #{numero.to_s}")
      user = User.create(name: "User #{numero.to_s}",
                  email: "bruce#{numero.to_s}@ironmaiden.com",
                  cpf: '45010589001',
                  cns: '6513516',
                  phone: '69999705594',
                  birth_date: 18.years.ago)
      UserCounty.create(county_id: county.id, user_id: user.id)
    end
  end
end

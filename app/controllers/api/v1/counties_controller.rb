class Api::V1::CountiesController < ApplicationController
  before_action :set_county, only: %i[show update update_status show_user]

  # GET /counties
  def index
    @counties = County.includes(:addresses, user_counties: %i[user county]).order('updated_at desc')

    return json_error_response('Não foi encontrado nenhum municipio', :not_found) unless @counties.present?

    render json: @counties, each_serializer: Api::V1::CountiesSerializer, status: :ok
  end

  def show_users
    users = User.all

    return json_error_response('Não foi encontrado pessoas', :not_found) unless users.present?

    render json: users, each_serializer: Api::V1::UsersSerializer, status: :ok
  end

  def show_user
    unless @county.user_counties.present?
      return json_error_response('Não foi encontrado pessoas neste municipio',
                                 :not_found)
    end

    render json: @county.user_counties, each_serializer: Api::V1::CountiesAndUsersSerializer, status: :ok
  end

  # GET /counties/1
  def show
    render json: { county: @county, new_users: User.all.select(:id, :name) }
  end

  def update_status
    @county.on? ? @county.update(status: :off) : @county.update(status: :on)
    status = @county.on? ? 'Inativado' : 'Ativado'
    render json: { messenger: "Municipio #{status}", county: @county }, status: :ok
  end

  # POST /counties
  def create
    resp = Operations::Api::V1::CountyCreate.new.call(county_params.merge(user_id: params[:user_id]))
    if resp.errors.present?
      render json: { messenger: resp.errors.first[:county] }, status: :unprocessable_entity
    else
      render json: @county
    end
  end

  # PATCH/PUT /counties/1
  def update
    resp = Operations::Api::V1::CountyUpdate.new.call(county_params.merge(user_id: params[:user_id], id: params[:id]))
    if resp.errors.present?
      render json: { messenger: resp.errors.full_messages.to_sentence }, status: :unprocessable_entity
    else
      render json: @county
    end
  end

  # DELETE /counties/1
  def destroy_user_county
    user_county = UserCounty.find_by(user_id: params[:user_id])
    user_county.destroy
    render json: { messenger: 'Pessoa removido(a)' }, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_county
    @county = County.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def county_params
    params.require(:county).permit(:name, :user_id, addresses_attributes: {})
  end
end

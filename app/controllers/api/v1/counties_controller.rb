class Api::V1::CountiesController < ApplicationController
  before_action :set_county, only: %i[ show update destroy update_status show_user]

  # GET /counties
  def index
    @counties = County.includes(:addresses, user_counties: [:user, :county]).order('updated_at desc')

    return json_error_response('Não foi encontrado nenhum Endereços municipal', :not_found) unless @counties.present?

    render json: @counties, each_serializer: Api::V1::CountiesSerializer, status: :ok
  end

  def show_user
    return json_error_response('Não foi encontrado pessoas neste municipio', :not_found) unless @county.user_counties.present?

    render json: @county.user_counties, each_serializer: Api::V1::CountiesAndUsersSerializer, status: :ok
  end
  # GET /counties/1
  def show
    render json: {county: @county, new_users: User.all.select(:id, :name)}
  end

  def update_status
    @county.on? ? @county.update(status: :off) : @county.update(status: :on)
    status = @county.on? ? 'Inativado' : 'Ativado'
    render json: { messenger: "Municipio #{status}"  ,county: @county }, status: :ok
  end
  # POST /counties
  def create
    @county = County.new(county_params)

    if @county.save
      render json: @county, status: :ok
    else
      render json: @county.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /counties/1
  def update
    process = Operations::Api::V1::CountyUpdate.new.call(county_params)
    if process.errors.present?

      render json: @county
    else
      render json: @county.errors, status: :unprocessable_entity
    end
  end

  # DELETE /counties/1
  def destroy
    @county.destroy
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

class Api::V1::AddressesController < ApplicationController
  before_action :set_address, only: %i[show update destroy]

  # GET /addresses
  def index
    address = Address.order('updated_at desc')

    return json_error_response('Não foi encontrado nenhum Endereços municipal', :not_found) unless address.present?

    render json: address, each_serializer: Api::V1::AddressSerializer, status: :ok
  end

  def show_counties
    counties = County.all.select(:id, :name)

    return json_error_response('Não foi encontrado municipios', :not_found) unless counties.present?

    render json: counties, status: :ok
  end

  # GET /addresses/1
  def show
    render json: { address: @address, new_counties: County.all.select(:id, :name) }
  end

  # POST /addresses
  def create
    @address = Address.new(address_params.merge(county_id: params[:county_id]))

    if @address.save
      render json: @address, status: :created, status: :ok
    else
      render json: @address.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /addresses/1
  def update
    if @address.update(address_params.merge(county_id: params[:county_id]))
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:cep, :complement, :street, :neighborhood, :city, :uf, :ibge_code, :county_id)
  end
end

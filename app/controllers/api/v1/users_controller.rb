class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update update_status]

  # GET /users
  def index
    @users = User.all.order('updated_at desc').limit(params[:limit]).offset(params[:offset])

    return json_error_response('Não foi encontrado nenhuma pessoa', :not_found) unless @users.present?

    render json: @users, each_serializer: Api::V1::UsersSerializer, status: :ok
  end

  def update_status
    @user.on? ? @user.update(status: :off) : @user.update(status: :on)
    status = @user.on? ? 'Inativado(a)' : 'Ativado(a)'
    render json: { messenger: "Pessoa #{status}", user: @user }, status: :ok
  end

  # GET /users/1
  def show
    render json: { user: @user }
  end

  # POST /users
  def create
    @user = User.new(user_params.merge(avatar: params[:avatar]))

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def avatar
    user = User.find(params[:id])
    if user.update(avatar: params[:avatar])
      render json: user, status: :ok
    else
      render json: { messenger: user.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    # if params.require(:user)[:avatar].present?
    #   @user.avatar.purge
    #   @user.avatar.attach(params.require(:user)[:avatar])
    # end

    if @user.update(user_params)
      render json: @user
    else
      render json: { messenger: @user.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :cpf, :cns, :email, :birth_date, :phone, :status, :avatar)
  end
end

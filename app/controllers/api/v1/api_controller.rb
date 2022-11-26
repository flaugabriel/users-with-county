class Api::V1::ApiController < ApplicationController
  def info
    render json: { messager: 'Welcome!' }
  end
end

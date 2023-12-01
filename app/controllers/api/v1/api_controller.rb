class ApiController < ApplicationController
  before_action :authenticate_request

  private
  def authenticate_request
    token = extract_token_from_header

    if token.present?
      begin
        decoded_token = JsonWebToken.decode(token)

      rescue JWT::Decode:error
        render json: { error: 'Invalid Token'}, status: :unauthorized
      else

      end

      render json: { error: 'Token missing'}, status: :unauthorized

      def  extract_token_from_header
        auth_header = request.headers['Authorization']
        token = auth_header.split('').last if auth_header.present?
        token
      end
  end

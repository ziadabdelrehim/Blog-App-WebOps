class ApplicationController < ActionController::Base
  before_action :authenticate_request


  

  def authenticate_request
    Rails.logger.debug "Authenticate request called"
    token = request.cookies['jwt']
    Rails.logger.debug "Token received: #{token}" 
    if token
      decoded_token = decode_jwt(token)
      Rails.logger.debug "Decoded token: #{decoded_token.inspect}"
      if decoded_token
        @current_user = User.find(decoded_token['user_id'])
        Rails.logger.debug "Current user: #{@current_user.inspect}"
      end
    end
  rescue StandardError => e
    Rails.logger.error "Authentication error: #{e.message}"
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end


  def current_user
    @current_user
  end

  private

  def decode_jwt(token)
    JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')[0]
  end
end

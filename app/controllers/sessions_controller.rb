class SessionsController < ApplicationController
  skip_before_action :authenticate_request, only: [:new, :create]

  # Render login form
  def new
    # This will render the login view
  end

  # Create session and handle login
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = generate_jwt(user)
      # Log the token
      Rails.logger.debug "JWT Token: #{token}"
      cookies[:jwt] = { value: token, httponly: true, secure: Rails.env.production? }
      redirect_to posts_timeline_path, notice: 'Logged in successfully'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  # Destroy session and handle logout
  def destroy
    cookies.delete(:jwt)
    redirect_to root_path, notice: 'Logged out successfully'
  end

  private

  def generate_jwt(user)
    payload = { user_id: user.id }
    JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
  end
end

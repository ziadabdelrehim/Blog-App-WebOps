class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]
  
    def create
      user_params = {
      name: params[:name],
      email: params[:email],
      password: params[:password],
      image: params[:image]
        }
        
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :image)
    end
  end
  
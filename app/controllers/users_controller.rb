class UsersController < ApplicationController
    before_action :authenticate_user!, :except => [:sign_up]

    def show
    end
    
    def update
      if current_user.update_attributes(user_params)
        render :show
      else
        render json: { errors: current_user.errors }, status: :unprocessable_entity
      end
    end

    def sign_up
      render json: { message: "Enter email, username and password" }
    end

    private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
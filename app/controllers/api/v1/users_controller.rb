module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_request, except: %i[create login]

      def index
        render json: {
          users: User.select(:name, :username)
        }, status: :ok
      end

      def show
        @user = User.find_by_id(params[:id])
        if @user.present?
          render json: {
            user: {
              name: @user.name,
              username: @user.username
            }
          }, status: :ok
        else
          render json: {
            error: "not found"
          }, status: :not_found
        end
      end

      def create
        render json: :ok
      end

      def login
        @user = User.find_by_username(user_params[:username])
        if @user&.authenticate(user_params[:password])
          time_expiration = Time.now + 10.hours
          token = JsonWebToken.encode({ user_id: @user.id }, time_expiration)
          render json: {
            token: token,
            exp: time_expiration.strftime("%Y-%m-%d %H:%M:%S"),
            username: @user.username
          }, status: :ok
        else
          render json: { error: "unauthorized" }, status: :unauthorized
        end
      end

      private

      def user_params
        params.permit(
          :name, :username, :password, :password_confirmation
        )
      end
    end
  end
end

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_request, except: %i[create login]
      before_action :validate_current_user, only: %i[update show destroy]

      api :GET, "/v1/users", "Show all users"
      header "Authorization", "define the token"
      # Show all users
      def index
        render json: {
          users: User.select(:id, :name, :username)
        }, status: :ok
      end

      api :GET, "/v1/users/:id", "Show user"
      header "Authorization", "define the token"
      # Show user
      def show
        render json: {
          user: {
            name: current_user.name,
            username: current_user.username
          }
        }, status: :ok
      end

      api :POST, "/v1/users", "Create user"
      header "Authorization", "define the token"
      param :name, String, required: true, desc: "name of the user"
      param :username, String, required: true, desc: "username of the user"
      param :password, String, required: true, desc: "password of the user"
      param :password_confirmation, String, required: true, desc: "password confirmation of the user"
      # Create user
      def create
        @user = User.new(user_params)
        if @user.save
          render json: {
            user: {
              name: @user.name,
              username: @user.username
            }
          }, status: :created
        else
          render json: {
            error: @user.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      api :PATCH, "/v1/users/:id", "Update user"
      header "Authorization", "define the token"
      param :name, String, required: true, desc: "name of the user"
      param :password, String, required: true, desc: "password of the user"
      param :password_confirmation, String, required: true, desc: "password confirmation of the user"
      # Update user
      def update
        if current_user.update(user_params)
          render json: {
            user: {
              name: current_user.name,
              username: current_user.username
            }
          }, status: :ok
        else
          render json: {
            error: current_user.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      api :POST, "/v1/users/login", "User login"
      param :username, String, required: true, desc: "username of the user"
      param :password, String, required: true, desc: "password of the user"
      # Authentication of user
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

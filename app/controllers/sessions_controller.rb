class SessionsController < Devise::SessionsController
    
    def new
      render json: { message: "Enter email and password" }
    end


    def create

      user = User.find_by_email(sign_in_params[:email])
  
      if user && user.valid_password?(sign_in_params[:password])
        @current_user = user
        render json: { message: 'You have successfully logged in', token: @current_user.generate_jwt }
      else
        render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
      end

    end

end
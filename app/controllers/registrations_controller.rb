class RegistrationsController < Devise::RegistrationsController

    def create 
        resource = User.new(sign_up_params)
        if resource.save
            render json:  { message: "You have successfully signed up, please activate your account by clicking the activation link that has been sent to your email address." }
        else
            render json: { errors: "You have not signed up" }, status: :unprocessable_entity
        end
    end

end
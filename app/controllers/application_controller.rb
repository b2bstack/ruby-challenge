class ApplicationController < ActionController::API
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    # protect_from_forgery with: :null_session
    # before_action :underscore_params!
    

    respond_to :json

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user , :except => [:home]

    def home
        if params[:alert]
          render json: { message: params[:alert] }
        else
          render json: { message: "Welcome to the API" }
        end
    end


    private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end

    def authenticate_user
        if request.headers['Authorization'].present?
            token = request.headers['Authorization'].split(' ').last
            begin

              # Verification for heroku Deployment
              if ENV['RAILS_ENV'] == 'development'
                jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first
              else ENV['RAILS_ENV'] == 'production'
                jwt_payload = JWT.decode(token, Rails.application.secret_key_base).first
              end

              @current_user_id = jwt_payload['id']
            rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError => e
              puts e
              head :unauthorized
            end
        end
    end


    def authenticate_user!(options = {})
        head :unauthorized unless current_user
    end
    
    def current_user
      if @current_user_id != nil
        @current_user ||= super || User.find(@current_user_id)
      end
    end
    
    def signed_in?
      @current_user_id.present?
    end

end

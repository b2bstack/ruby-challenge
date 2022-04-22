class ApplicationController < ActionController::API
  def authorize_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user_id = @decoded[:user_id]
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def validate_current_user
    render json: { errors: "bad news" }, status: :forbidden if @current_user_id != params[:id].to_i
  end

  def current_user
    @current_user ||= User.find_by_id(@current_user_id)

    render json: { errors: "not_found" }, status: :not_found if @current_user.nil?

    @current_user
  end
end

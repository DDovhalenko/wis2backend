class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :json

  def configure_permitted_parameters
    attributes = [:name, :surname]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    devise_parameter_sanitizer.permit(:update, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  def create
    @user = User.create!(sign_up_params)
    @user.save
    current_user = @user
    token = JsonWebToken.encode(user_id: resource.id)
      time = Time.now + 24.hours.to_i
      render json:{token: token, exp: time.strftime("%m-%d-%Y %H:%M"), user: @user}
  end


  private

  def user_params
    params.require(:user).permit(:password)
  end

  def user_params
    params.require(:user).permit(:name,:surname,:email,:password)
  end
  
end
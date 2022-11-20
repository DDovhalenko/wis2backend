class SessionsController < Devise::SessionsController
  respond_to :json
  
  def create
    @user = User.find_by_email(params[:user][:email])
    if(@user.valid_password?(params[:user][:password]))
      sign_in(:user, @user)
      #token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json:{token: token, exp: time.strftime("%m-%d-%Y %H:%M"), user: @user}
      
    end

  end

  private
  def respond_with(resource, _opts = {})
    render json: resource
  end
  def respond_to_on_destroy
    render json: { message: "Logged out." }
  end
end
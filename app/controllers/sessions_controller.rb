class SessionsController < Devise::SessionsController
  respond_to :json
  
  def create
    @user = User.find_by_email(params[:user][:email])
    #current_user = @user
    if(@user.valid_password?(params[:user][:password]))
      sign_in(:user, @user)
      render json:{user: @user}
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
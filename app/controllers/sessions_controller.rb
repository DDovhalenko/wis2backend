class SessionsController < Devise::SessionsController
  def create
    @user = User.find_by_email(user_params[:email])
    return invalid_login_attempt unless @user

    if @user.valid_password?(user_params[:password])
      sign_in :user, @user
      session[:user_id]=@user.id
      render json: @user
    else
      invalid_login_attempt
    end
  end

  def destroy
    sign_out(@user)
    render :json=> {:success=>true}
  end


    private

    def invalid_login_attempt
      warden.custom_failure!
      render json: {error: 'invalid login attempt'}, status: :unprocessable_entity
    end

    def user_params
       params.require(:user).permit(:email, :password)
    end

    def after_sign_out_path_for(resource_or_scope)
      respond_to?(:root_path) ? root_path : "/"
     end
  end
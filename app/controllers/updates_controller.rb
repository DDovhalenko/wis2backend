class UpdatesController < Devise::RegistrationsController
    before_action :authorize_request
def update_user
    @user = current_user
    @existing_email = User.where("email = ?",params[:user][:email]).first
    if(!@existing_email || @existing_email.id == @user.id)
        @user.name = params[:user][:name]
        @user.surname = params[:user][:surname]
        @user.email = params[:user][:email]
        @user.save
        render json: @user
    else
        render json: {text:"not Unique email"}
    end
  end

  def update_password
    @user = current_user
    @user.password = params[:user][:password]
    @user.save
    render json: @user
  end

  def update_user_role
    @user = User.find(params[:user][:id])
    @user.role = params[:user][:role]
    @user.save
    render json: @user
  end
end

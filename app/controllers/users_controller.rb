class UsersController < ApplicationController
    before_action :authorize_request

    def show
        @users = User.all
        render json: @users
    end
end
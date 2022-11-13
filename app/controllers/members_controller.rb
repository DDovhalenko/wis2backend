class MembersController < ApplicationController
    before_action :authenticate_user!
    def show
      render json: {
        message: "This is a secret message. You are seeing it because you have successfully logged in." 
      }
    end
  end
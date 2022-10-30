class MainController < ApplicationController
    before_action :authenticate_user!
    def mainpage
    end
end
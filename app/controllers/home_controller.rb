class HomeController < ApplicationController
    
    def homepage
        if current_user
            render json:{
                logged_in: true,
                user: current_ser
            }
        end
    end
end
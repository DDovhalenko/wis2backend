class CoursesController < ApplicationController
    # GET /courses
    def index
        @courses = Course.all
        render json: @courses
    end

    # POST /courses
    def create
        @user = current_user
        if(@user)
            @course = @user.courses.create!(course_params)
        end
        render json: @course, status: :created, location: @course
    end

    private 
    # Only allow a trusted parameter "white list" through.
    def course_params
        params.require(:course).permit(:name, :full_name, :description, :course_type, :price)
    end
end

  
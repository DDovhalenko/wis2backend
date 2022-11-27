class PublicCoursesController < ApplicationController
    def show
        @courses = Course.all
        render json: @courses
    end
  end
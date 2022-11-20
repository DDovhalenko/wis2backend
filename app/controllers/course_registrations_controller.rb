class CourseRegistrationsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_request

    #get /course_registrations
    def index
        @user = current_user
        @courses = Course.joins(:course_registrations).where("course_registrations.user_id = ?",@user.id)
        render json: {courses:@courses}
    end

    #post /course_registrations
    def create
        @user = current_user
        @course  = Course.where("name = ?", params[:course][:name]).first
        begin
            @registration = @course.users<<@user
            render json:{message: "creating registration"}
        rescue ActiveRecord::RecordNotUnique
            render json:{status:"notUnique"}
        end
    end
end
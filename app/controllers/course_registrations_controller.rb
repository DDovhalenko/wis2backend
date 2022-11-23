class CourseRegistrationsController < ApplicationController
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
        @course  = Course.find(params[:course][:id])
        begin
            @registration = @course.users<<@user
            render json:{message: "creating registration"}
        rescue ActiveRecord::RecordNotUnique
            render json:{status:"notUnique"}
        end
    end

    def destroy
        @user = current_user
        @course_registration = CourseRegistration.where(["user_id = ? and course_id = ?", @user.id, params[:course][:id]]).first
        if(@course_registration.destroy!)
            render json: {status: :ok}
        end
    end
end
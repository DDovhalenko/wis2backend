class CoursesController < ApplicationController
    before_action :authorize_request

    # GET /courses
    def index
        @counts = Course.includes(:course_registrations).map { |course| { id: course.id,
            user_id:course.user_id,name:course.name,full_name:course.full_name,
            description:course.description,course_type:course.course_type,price:course.price,limit:course.limit,
             count: course.course_registrations.size }}
        render json: @counts
    end

    # POST /courses
    def create
        @user = current_user
        if(@user)
            @course = @user.courses.create!(course_params)
        end
        render json: @course, status: :created, location: @course
    end

    def update_course
        @course = Course.find(params[:course][:id])
        if(@course)
            @course.name = params[:course][:name]
            @course.full_name = params[:course][:full_name]
            @course.description = params[:course][:description]
            @course.course_type = params[:course][:course_type]
            @course.price = params[:course][:price]
            @course.limit = params[:course][:limit]
            @course.save
            @term=Term.where("course_id = ?", @course.id).update_all(name:@course.name)   
            render json: @course
        else
            render json: {status: :not_modified}
        end
    end

    def destroy
        @course = Course.find(params[:id])
        if(@course.destroy!)
            render json: {status: :ok}
        end
    end

    private 
    # Only allow a trusted parameter "white list" through.
    def course_params
        params.require(:course).permit(:name, :full_name, :description, :course_type, :price, :limit)
    end
end

  
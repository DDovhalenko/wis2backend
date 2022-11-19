class TermsController < ApplicationController
    # GET /terms
    def index
        @terms = Term.all
        render json: @courses
    end

    # POST /terms
    def create
        @user = current_user
        @course = Course.where("name =?", params[:term][:name]).first
        if(@user)
            @term = @user.terms.create!({:course_id => @course.id, :name => params[:term][:name], :term_type => params[:term][:term_type]})
            @term_to_course = @course.terms<<@term
        end
        render json: @term, status: :created, location: @term
    end
end
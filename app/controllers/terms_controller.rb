class TermsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_request

    # GET /terms
    def index
        @terms = Term.all
        render json: @courses
    end

    # POST /terms
    def create
        @user = current_user
        @room = Room.where(["name = ?",params[:room][:name]])
        @course = Course.where("name =?", params[:term][:name]).first
        @room_registrations = RoomRegistration.where(["date = ?",params[:term][:date]]).all
        @room_registration_same_time = @room_registrations.where(["(time_start < ? and time_end > ?) or (time_start < ? and time_end > ?)",
            params[:term][:time_start], params[:term][:time_start],params[:term][:time_end],params[:term][:time_start]]).first
        if(@user)
            if(!@room_registration_same_time)
                @term = @user.terms.create!({:course_id => @course.id, :name => params[:term][:name], :term_type => params[:term][:term_type], :date => params[:term][:date], :time_start => params[:term][:time_start], :time_end => params[:term][:time_end], :limit => params[:term][:limit]})
                @term_to_course = @course.terms<<@term
                @term.rooms<<@room
                @term_to_room = RoomRegistration.where(["term_id = ? and room_id = ?", @term.id, @room.ids]).first
                @term_to_room.date = @term.date
                @term_to_room.time_start = @term.time_start
                @term_to_room.time_end = @term.time_end
                @term_to_room.save
                render json: @term, status: :created, location: @term
            else 
                render json: status: :not_modified
            end
        end    
    end
end
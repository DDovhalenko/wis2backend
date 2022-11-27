class TermsController < ApplicationController
    before_action :authorize_request

    def show_terms
        @terms = Term.where("course_id = ?",params[:course][:id]).all
        @rooms = Room.joins(:room_registrations)
        @counts = @terms.includes(:term_registrations).map { |term| { course_id:term.course_id, date:term.date,
            id:term.id, limit:term.limit, name:term.name, term_type:term.term_type, time_end:term.time_end,
            time_start:term.time_start,user_id:term.user_id, count: term.term_registrations.size, 
            room:@rooms.where("term_id = ?",term.id).first.name}}
        render json: @counts
    end

    # POST /terms
    def create
        @user = current_user
        @room = Room.find(params[:room][:id])
        @course = Course.find(params[:course][:id])
        @room_registrations = RoomRegistration.where(["date = ?",params[:term][:date]]).all
        @room_registration_same_time = @room_registrations.where(["(time_start < ? and time_end > ?) or (time_start < ? and time_end > ?)",
            params[:term][:time_start], params[:term][:time_start],params[:term][:time_end],params[:term][:time_start]]).first
        if(@user)
            if(!@room_registration_same_time)
                @term = @user.terms.create!({:course_id => @course.id, :name => @course.name, :term_type => params[:term][:term_type], :date => params[:term][:date], :time_start => params[:term][:time_start], :time_end => params[:term][:time_end], :limit => params[:term][:limit]})
                @term_to_course = @course.terms<<@term
                @term.rooms<<@room
                @term_to_room = RoomRegistration.where(["term_id = ? and room_id = ?", @term.id, @room.id]).first
                @term_to_room.date = @term.date
                @term_to_room.time_start = @term.time_start
                @term_to_room.time_end = @term.time_end
                @term_to_room.save
                render json: @term, status: :created, location: @term
            else 
                render json: {},status: :conflict
            end
        end    
    end

    def destroy
        @term = Term.find(params[:id])
        if(@term.destroy!)
            render json: {status: :ok}
        end
    end
end
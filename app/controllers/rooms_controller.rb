class RoomsController < ApplicationController
    before_action :authorize_request

    # GET /rooms
    def index
        @rooms = Room.all
        render json: @rooms
    end

    # POST /rooms
    def create
        @user = current_user
        if(@user)
            @room = Room.create!(room_params)
        end
        render json: @room, status: :created, location: @room
    end

    def destroy
        @room_registrations = RoomRegistration.where("room_id = ?", params[:id]).all
        @room_registrations.map{|r| Term.find([r.term_id]).first.destroy}
        @room = Room.find(params[:id])
        if(@room.destroy!)
            render json: {status: :ok}
        end
    end

    private 
    # Only allow a trusted parameter "white list" through.
    def room_params
        params.require(:room).permit(:name, :limit)
    end
end
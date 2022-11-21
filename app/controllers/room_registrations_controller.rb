class RoomRegistrationsController < ApplicationController
    before_action :authorize_request

    #get /room_registrations
    def index
        @user = current_user
        @terms = Term.joins(:term_registrations).where("term_registrations.user_id = ?",@user.id)
        render json: {terms:@terms}
    end
end
class TermRegistrationsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_request

    #get /term_registrations
    def index
        @user = current_user
        @terms = Term.joins(:term_registrations).where("term_registrations.user_id = ?",@user.id)
        render json: {terms:@terms}
    end

    #post /term_registrations
    def create
        @user = current_user
        @term  = Term.where(["name = ? and term_type = ?", params[:term][:name], params[:term][:term_type]]).first
        begin
            @registration = @term.users<<@user
            render json:{message: "creating registration"}
        rescue ActiveRecord::RecordNotUnique
            render json:{status:"notUnique"}
        end
    end
end
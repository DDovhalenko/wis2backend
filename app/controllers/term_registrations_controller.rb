class TermRegistrationsController < ApplicationController
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
        @term  = Term.find(params[:term][:id])
        begin
            @registration = @term.users<<@user
            render json:{message: "creating registration"}
        rescue ActiveRecord::RecordNotUnique
            render json:{status:"notUnique"}
        end
    end

    def destroy
        @user = current_user
        @term_registration = TermRegistration.where(["user_id = ? and term_id = ?", @user.id, params[:term][:id]]).first
        if(@term_registration.destroy!)
            render json: {status: :ok}
        end
    end
end
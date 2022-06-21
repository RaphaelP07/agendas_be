module Api
  module V1
    class MeetingsController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_meeting, only: %i[ show update destroy show_members add_member remove_member ]
      before_action :get_organisation, only: %i[ index create update ]
      before_action :get_user, only: %i[ create ]
      before_action :member, only: %i[ remove_member ]
      respond_to :json

      # GET /meetings
      def index
        @meetings = @organisation.meetings

        render json: @meetings
      end

      # GET /meetings/1
      def show
        render json: @meeting
      end

      # POST /meetings
      def create
        @meeting = @organisation.meetings.new(meeting_params)
        meeting_already_exists = @organisation.meetings.exists?(agenda: meeting_params['agenda'])

        if meeting_already_exists
          render json: {
            message: "This meeting name already taken in this organisation."
          }, status: :bad_request
          return
        end

        if @meeting.save
          @meeting.users << @user
          render json: @meeting, status: :created
        else
          render json: @meeting.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /meetings/1
      def update
        if @meeting.update(meeting_params)
          render json: @meeting
        else
          render json: @meeting.errors, status: :unprocessable_entity
        end
      end

      # DELETE /meetings/1
      def destroy
        @meeting.destroy

        render json: {
          message: "Successfully deleted meeting."
        }, status: :ok
      end

      def show_members
        render json: @meeting.users
      end

      def send_invites
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_meeting
        @meeting = Organisation.find(params[:organisation_id]).meetings.find(params[:id])
      end

      def get_user
        @user = current_api_v1_user
      end

      # Only allow a list of trusted parameters through.
      def meeting_params
        params.require(:meeting).permit(:agenda, :notes)
      end
    end
  end
end

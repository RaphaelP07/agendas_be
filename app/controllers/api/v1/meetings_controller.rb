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
        meeting_already_exists = @organisation.meetings.exists?(name: meeting_params['name'])


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
        same_name = @meeting['name'] == meeting_params['name']
        meeting_already_exists = @organisation.meetings.exists?(name: meeting_params['name'])

        if same_name
          render json: {
            message: "Edited meeting name cannot be the same as the orginal name."
          }, status: :bad_request
          return
        end

        if meeting_already_exists
          render json: {
            message: "This meeting name is already taken in this organisation."
          }, status: :bad_request
          return
        end

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

      def add_member
        already_in_meeting = @meeting.users.include?(member)
        
        if already_in_meeting
          render json: {
            message: "#{member[:email]} is already in this meeting."
            }, status: :bad_request
          return
        end
          
        @meeting.users << member

        render json: {
          message: "Successfully added #{member['email']} to meeting."
        }, status: :ok
      end

      def remove_member
        not_in_meeting = @meeting.users.include?(member) == false
        
        if not_in_meeting
          render json: {
            message: "This user is not in this meeting."
            }, status: :bad_request
          return
        end
        
        @meeting.users.delete(member)

        render json: {
          message: "Successfully removed #{member['email']} from meeting."
        }, status: :ok
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
        params.require(:meeting).permit(:name)
      end
    end
  end
end

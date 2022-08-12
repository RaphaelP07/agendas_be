module Api
  module V1
    class MeetingsController < ApplicationController
      before_action :set_meeting, only: %i[ show update destroy show_participants send_invite ]
      before_action :get_organisation, only: %i[ index create update ]
      before_action :get_user, only: %i[ create ]
      before_action :member, only: %i[ send_invite ]
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
            message: "This meeting name is already taken."
          }, status: :bad_request
          return
        end

        meeting_is_sync = @meeting['synchronicity'] == "sync"
        response = DailyCo::Client::create_room(meeting_params) if meeting_is_sync
        room_creation_failed = response[:code] != 200 if meeting_is_sync

        if room_creation_failed
          render json: {
            error: response[:data]
            }, status: :bad_request
          return
        end

        if @meeting.save
          if meeting_is_sync
            @meeting.update(url: response[:data]['url'])
          else
            @meeting.update(url: "http://localhost:3001/agendas/meetings/#{@meeting['id']}")
          end
          @meeting.users << @user
          render json: {
            data: @meeting
          }, status: :created
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
        DailyCo::Client::delete_room(@meeting['url'].split('', 26)[-1])

        render json: {
          message: "Successfully deleted meeting."
        }, status: :ok
      end

      def show_participants
        render json: {
          meeting: @meeting,
          users: @meeting.users
        }
      end

      def send_invite
        InviteMailer.with(user: member, meeting: @meeting).send_invite.deliver_later
        @meeting.users << member
        render json: {
          recipient: member['email'],
          meeting: @meeting
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
        params.require(:meeting).permit(:name, :notes, :synchronicity, :schedule, :url)
      end
    end
  end
end

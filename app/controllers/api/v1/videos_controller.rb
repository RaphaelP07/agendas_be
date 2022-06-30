module Api
  module V1
    class VideosController < ApplicationController
      before_action :set_video, only: %i[ show update destroy ]
      before_action :get_meeting, only: %i[ index create show update destroy ]
      before_action :get_user, only: %i[ index create show update destroy ]

      # GET /videos
      def index
        @videos = @meeting.videos

        render json: @videos
      end

      # GET /videos/1
      def show
        render json: @video
      end

      # POST /videos
      def create
        @video = @meeting.videos.new(video_params)

        # upload video to api_video
        auth = ApiVideo::Client.auth
        create = ApiVideo::Client.create(auth[:data]['access_token'], video_params['name'])
        upload = ApiVideo::Client.upload(auth[:data]['access_token'], create[:data]['videoId'], video_params['pathname'])
        status = ApiVideo::Client.status(upload[:data]['videoId'])

        upload_failed = [
          auth[:code] != 200,
          create[:code] == 400,
          upload[:code] != 201,
          status[:code] != 200].all? {
            |i| i == false
          } == false

        if upload_failed
          render json: {
            message: "Upload failed."
          }, status: :bad_request
          return
        end

        if @video.save
          @video.update(
            upload_status: status[:data]['ingest']['status'],
            duration: status[:data]['metadata']['duration'],
            embed_url: upload[:data]['assets']['player'],
            source_url: upload[:data]['assets']['mp4']
          )
          render json: @video, status: :created, location: @video
        else
          render json: @video.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /videos/1
      def update
        if @video.update(video_params)
          render json: @video
        else
          render json: @video.errors, status: :unprocessable_entity
        end
      end

      # DELETE /videos/1
      def destroy
        @video.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_video
        @video = Video.find(params[:id])
      end

      def get_meeting
        @meeting = Meeting.find(params[:meeting_id])
      end

      def get_user
        @user = current_api_v1_user
      end

      # Only allow a list of trusted parameters through.
      def video_params
        params.require(:video).permit(:name, :pathname)
      end
    end
  end
end

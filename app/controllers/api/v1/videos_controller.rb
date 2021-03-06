module Api
  module V1
    class VideosController < ApplicationController
      before_action :set_video, only: %i[ show destroy render_status ]
      before_action :get_meeting, only: %i[ index create show update destroy render_meeting ]
      before_action :get_user, only: %i[ index create show update destroy ]

      # GET /videos
      def index
        @videos = @meeting.videos.sort

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
        status = ApiVideo::Client.status(create[:data]['videoId'])

        while status[:data]['encoding']['metadata']['duration'] == nil
          sleep 3
          status = ApiVideo::Client.status(create[:data]['videoId'])
        end

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
            video_type: 'user upload',
            upload_status: status[:data]['ingest']['status'],
            duration: status[:data]['encoding']['metadata']['duration'].to_i,
            embed_url: upload[:data]['assets']['player'],
            source_url: upload[:data]['assets']['mp4'],
            api_video_id: upload[:data]['videoId']
          )
          render json: @video, status: :created
        else
          render json: @video.errors, status: :unprocessable_entity
        end
      end

      # DELETE /videos/1
      def destroy
        @video.destroy

        if @video['render_id'] == nil
          auth = ApiVideo::Client.auth
          delete = ApiVideo::Client.delete(auth[:data]['access_token'], @video['api_video_id'])
        end

        render json: {
          message: "Successfully deleted video."
        }, status: :ok
      end

      def render_meeting
        @videos = @meeting.videos.map {|video| video}
        @video = @meeting.videos.new(video_params)
        
        render_meeting = Shotstack::Client.render_meeting(@videos.sort)

        if @video.save
          @video.update(
            video_type: 'rendered meeting',
            render_status: 'rendering',
            render_id: render_meeting[:data]['response']['id']
          )
          render json: @video, status: :created
        else
          render json: @video.errors, status: :unprocessable_entity
        end
      end

      def render_status
        if @video['upload_status'] != 'done'
          render_status = Shotstack::Client.render_status(@video['render_id'])
          @video.update(
            render_status: render_status[:data]['response']['status'],
            duration: render_status[:data]['response']['duration'].to_i,
            source_url: render_status[:data]['response']['url']
          )
        end

        render json: @video
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
        params.require(:video).permit(:name, :pathname, :user_id)
      end
    end
  end
end

module Api
  module V1
    class ApiVideoController < ApplicationController

      def auth
        auth = ApiVideo::Client.auth
        render json: auth
      end
      
      def videos
        get_videos = ApiVideo::Client.get_videos
        render json: get_videos
      end

      def create
        create = ApiVideo::Client.create(params[:title])
        render json: create
      end

      def upload
        upload = ApiVideo::Client.upload(params[:video_id])
        render json: upload
      end
    end
  end
end
module Api
  module V1
    class ApiVideoController < ApplicationController

      def videos
        get_videos = ApiVideo::Client.get_videos
        render json: get_videos
      end

      def video
        video = ApiVideo::Client.get_video(params[:videoId])
        render json: video
      end

      def status
        video = ApiVideo::Client.status(params[:videoId])
        render json: video
      end

      def upload
        auth = ApiVideo::Client.auth
        create = ApiVideo::Client.create(auth[:data]['access_token'], params[:title])
        upload = ApiVideo::Client.upload(auth[:data]['access_token'], create[:data]['videoId'], params[:pathname])
        render json: upload
      end

      def delete
        auth = ApiVideo::Client.auth
        delete = ApiVideo::Client.delete(auth[:data]['access_token'], params[:videoId])
        render json: delete
      end
    end
  end
end
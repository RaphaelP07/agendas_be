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

      # def video
      #   get_video = DailyCo::Client.get_video(params[:name])
      #   render json: get_video
      # end
    end
  end
end
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

      def upload
        upload = ApiVideo::Client.upload(video_id)
        render json: upload
      end

      private

      def video_id
        word = 'tests'
        name = word.split('')
        i = 0
        string = []
        while i < 4
          o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
          string.push((0...4).map { o[rand(o.length)] }.join)
          if name[i] == nil
            string.push('a'..'z')
          else
            string.push(name[i])
          end
          i += 1
        end
        string.join
      end

      # def video
      #   get_video = DailyCo::Client.get_video(params[:name])
      #   render json: get_video
      # end
    end
  end
end
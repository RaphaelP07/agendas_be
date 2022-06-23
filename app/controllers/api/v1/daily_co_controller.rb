module Api
  module V1
    class DailyCoController < ApplicationController
      
      def rooms
        get_rooms = DailyCo::Client.get_rooms
        render json: get_rooms
      end

      def room
        get_room = DailyCo::Client.get_room(params[:name])
        render json: get_room
      end
    end
  end
end
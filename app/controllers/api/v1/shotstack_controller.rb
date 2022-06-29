module Api
  module V1
    class ShotstackController < ApplicationController
      
      # def templates
      #   templates = Shotstack::Client.templates
      #   render json: templates
      # end

      # def template
      #   template = Shotstack::Client.template(params[:template_id])
      #   render json: template
      # end

      def render_meeting
        render_meeting = Shotstack::Client.render_meeting
        render json: render_meeting
      end
    end
  end
end
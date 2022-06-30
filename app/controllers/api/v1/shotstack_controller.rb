module Api
  module V1
    class ShotstackController < ApplicationController
      def templates
        templates = Shotstack::Client.templates
        render json: templates
      end

      def template
        template = Shotstack::Client.template(params[:template_id])
        render json: template
      end
      
      def create_template
        template = Shotstack::Client.create_template(params[:body])
        render json: template
      end
      
      def render_status
        render_status = Shotstack::Client.render_status(params[:render_id])
        render json: render_status
      end
      
      def render_meeting
        render_meeting = Shotstack::Client.render_meeting
        render json: render_meeting
      end

      # def webhook
      #   puts "#{params[:action]} #{params[:status]}"
      # end
    end
  end
end
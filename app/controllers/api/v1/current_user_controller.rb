module Api
  module V1
    class CurrentUserController < ApplicationController
      before_action :authenticate_api_v1_user!
      def index
        render json: current_api_v1_user, status: :ok
      end
    end 
  end
end

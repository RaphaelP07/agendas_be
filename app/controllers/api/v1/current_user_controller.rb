module Api
  module V1
    class CurrentUserController < ApplicationController
      before_action :authenticate_api_v1_user!
      def index
        render json: current_api_v1_user, status: :ok
      end

      def name
        if current_api_v1_user.update(first_name: params['first_name'], last_name: params['last_name'])
          render json: current_api_v1_user
        else
          render json: current_api_v1_user.errors, status: :unprocessable_entity
        end
      end
    end 
  end
end

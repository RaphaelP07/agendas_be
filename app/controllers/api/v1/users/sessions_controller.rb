# frozen_string_literal: true

module Api
  module V1
    class Users::SessionsController < Devise::SessionsController
      respond_to :json
      
      private
      
      def respond_with(resource, _opts = {})
      render json: {
        status: {code: 200, message: 'Logged in sucessfully.'},
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
        }, status: :ok
      end
      
      def respond_to_on_destroy
        if current_user
          render json: {
            status: 200,
            message: "logged out successfully"
          }, status: :ok
        else
          render json: {
            status: 401,
            message: "Couldn't find an active session."
          }, status: :unauthorized
        end
      end

      def sign_in_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
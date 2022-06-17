module Api
  module V1
    class OrganisationsController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_organisation, only: %i[ show update destroy create_team ]
      before_action :get_user, only: %i[ index create join create_team ]
      respond_to :json

      # GET /organisations
      def index
        @organisations = @user.organisations.all

        render json: @organisations
      end

      # GET /organisations/1
      def show
        render json: @organisation
      end

      # POST /organisations
      def create
        @organisation = @user.organisations.new(organisation_params)

        if @organisation.save
          @organisation.update(link: generate_string(@organisation[:name]))
          @organisation.users << @user
          render json: @organisation, status: :created
        else
          render json: @organisation.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /organisations/1
      def update
        if @organisation.update(organisation_params)
          render json: @organisation
        else
          render json: @organisation.errors, status: :unprocessable_entity
        end
      end

      # DELETE /organisations/1
      def destroy
        @organisation.destroy
      end

      # POST /organisations/1/teams
      def create_team
        
      end

      def join
        @organisation = Organisation.where(link: params[:link])[0]
        already_joined = @organisation.users.include?(@user) if @organisation != nil

        if already_joined
          render json: {
            message: "You have already joined #{@organisation[:name]}."
          }, status: :bad_request
          return
        end

        if @organisation
          @organisation.users << @user
          render json: {
            data: @organisation, 
            message: "Successfully joined #{@organisation[:name]}."
          }, status: :accepted
        else
          render json: {
            message: 'Incorrect organisation code.'
          }, status: :not_found
        end
      end

      private

      def set_organisation
        @organisation = Organisation.find(params[:id])
      end

      def get_user
        @user = current_api_v1_user
      end

      def organisation_params
        params.require(:organisation).permit(:name, :city_address, :link)
      end

      def team_params
        params.require(:team).permit(:name, :organisation_id)
      end

      def meeting_params
        params.require(:meeting).permit(:agenda, :notes)
      end

      def generate_string(string)
        name = string.split('')
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
    end
  end
end
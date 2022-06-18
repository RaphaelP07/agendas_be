module Api
  module V1
    class TeamsController < ApplicationController
      before_action :set_team, only: %i[ show update destroy add_member ]

      # GET /teams
      def index
        @teams = @organisation.teams.all

        render json: @teams
      end

      # GET /teams/1
      def show
        render json: @team
      end

      # POST /teams
      def create
        @team = @organisation.teams.new(team_params)
        team_already_exists = @organisation.teams.include?(@team)

        if team_already_exists
          render json: {
            message: "This team name already taken in this organisation."
          }, status: :bad_request
          return
        end

        if @team.save
          @team.users << @user
          render json: @team, status: :created, location: @team
        else
          render json: @team.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /teams/1
      def update
        if @team.update(team_params)
          render json: @team
        else
          render json: @team.errors, status: :unprocessable_entity
        end
      end

      # DELETE /teams/1
      def destroy
        @team.destroy
      end

      def add_member
        @team.users << member
      end

      def remove_member
        @team.users.delete(member)
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_team
        @team = Organisation.teams.find(params[:id])
      end

      def get_organisation
        @organisation = Organisation.find(params[:organisation_id])
      end

      def get_user
        @user = current_api_v1_user
      end

      def member
        User.find(params[:user_id])
      end

      # Only allow a list of trusted parameters through.
      def team_params
        params.require(:team).permit(:name)
      end
    end
  end
end

module Api
  module V1
    class TeamsController < ApplicationController
      before_action :set_team, only: %i[ show update destroy show_members add_member remove_member ]
      before_action :get_organisation, only: %i[ index create update ]
      before_action :get_user, only: %i[ create ]
      before_action :member, only: %i[ remove_member ]
      respond_to :json

      # GET /teams
      def index
        @teams = @organisation.teams

        render json: @teams
      end

      # GET /teams/1
      def show
        render json: @team
      end

      # POST /teams
      def create
        @team = @organisation.teams.new(team_params)
        team_already_exists = @organisation.teams.exists?(name: team_params['name'])


        if team_already_exists
          render json: {
            message: "This team name already taken in this organisation."
          }, status: :bad_request
          return
        end

        if @team.save
          @team.users << @user
          render json: @team, status: :created
        else
          render json: @team.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /teams/1
      def update
        same_name = @team['name'] == team_params['name']
        team_already_exists = @organisation.teams.exists?(name: team_params['name'])

        if same_name
          render json: {
            message: "Edited team name cannot be the same as the orginal name."
          }, status: :bad_request
          return
        end

        if team_already_exists
          render json: {
            message: "This team name is already taken in this organisation."
          }, status: :bad_request
          return
        end

        if @team.update(team_params)
          render json: @team
        else
          render json: @team.errors, status: :unprocessable_entity
        end
      end

      # DELETE /teams/1
      def destroy
        @team.destroy

        render json: {
          message: "Successfully deleted team."
        }, status: :ok
      end

      def show_members
        render json: @team.users
      end

      def add_member
        already_in_team = @team.users.include?(member)
        
        if already_in_team
          render json: {
            message: "#{member[:email]} is already in this team."
            }, status: :bad_request
          return
        end
          
        @team.users << member

        render json: {
          message: "Successfully added #{member['email']} to team."
        }, status: :ok
      end

      def remove_member
        not_in_team = @team.users.include?(member) == false
        
        if not_in_team
          render json: {
            message: "This user is not in this team."
            }, status: :bad_request
          return
        end
        
        @team.users.delete(member)

        render json: {
          message: "Successfully removed #{member['email']} from team."
        }, status: :ok
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_team
        @team = Organisation.find(params[:organisation_id]).teams.find(params[:id])
      end

      def get_user
        @user = current_api_v1_user
      end

      # Only allow a list of trusted parameters through.
      def team_params
        params.require(:team).permit(:name)
      end
    end
  end
end

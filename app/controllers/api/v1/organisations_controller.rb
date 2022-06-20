module Api
  module V1
    class OrganisationsController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_organisation, only: %i[ show update destroy show_members remove_member ]
      before_action :get_user, only: %i[ index create show join show_members remove_member ]
      before_action :member, only: %i[ remove_member ]
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
        @organisation = @user.organisations.new(org_params)

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
        if not_admin
          render json: {
            message: "Only the admin can update the organisation info."
            }, status: :method_not_allowed
          return
        end

        same_name = @organisation['name'] == org_params['name']
        org_already_exists = Organisation.all.exists?(name: org_params['name'])

        if same_name
          render json: {
            message: "Edited organisation name cannot be the same as the orginal name."
          }, status: :bad_request
          return
        end

        if org_already_exists
          render json: {
            message: "This organisation name is already taken."
          }, status: :bad_request
          return
        end

        if @organisation.update(org_params)
          render json: @organisation
        else
          render json: @organisation.errors, status: :unprocessable_entity
        end
      end

      # DELETE /organisations/1
      def destroy
        if not_admin
          render json: {
            message: "Only the admin can delete the organisation."
            }, status: :method_not_allowed
          return
        end

        @organisation.destroy

        render json: {
          message: "Successfully deleted organisation."
        }, status: :ok
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

      def remove_member
        not_in_org = @organisation.users.include?(member) == false
        
        if not_in_org
          render json: {
            message: "This user is not in this org."
            }, status: :bad_request
          return
        end

        if not_admin
          render json: {
            message: "Only the admin can delete members."
            }, status: :method_not_allowed
          return
        end
        
        @organisation.users.delete(member)

        render json: {
          message: "Successfully removed #{member['email']} from organisation."
        }, status: :ok
      end

      def show_members
        render json: @organisation.users
        # render json: @organisation.users.where.not(id: @user.id)
      end

      private

      def set_organisation
        @organisation = Organisation.find(params[:id])
      end

      def get_user
        @user = current_api_v1_user
      end

      def org_params
        params.require(:organisation).permit(:name, :city_address, :link)
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
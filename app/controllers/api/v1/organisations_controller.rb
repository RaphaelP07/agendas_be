class OrganisationsController < ApplicationController
  before_action :set_organisation, only: %i[ show update destroy create_team ]

  # GET /organisations
  def index
    @organisations = Organisation.all

    render json: @organisations
  end

  # GET /organisations/1
  def show
    render json: @organisation
  end

  # POST /organisations
  def create
    @organisation = Organisation.new(organisation_params)

    if @organisation.save
      render json: @organisation, status: :created, location: @organisation
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
    @organisation
  end

  private

    def set_organisation
      @organisation = Organisation.find(params[:id])
    end

    def organisation_params
      params.require(:organisation).permit(:name, :city_address)
    end

    def team_params
      params.require(:team).permit(:name, :organisation_id)
    end

    def meeting_params
      params.require(:meeting).permit(:agenda, :notes)
    end
end

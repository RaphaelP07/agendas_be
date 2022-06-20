class ApplicationController < ActionController::API
  private

  def get_organisation
    @organisation = Organisation.find(params[:organisation_id])
  end
end

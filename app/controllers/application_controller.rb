class ApplicationController < ActionController::API
  private

  def get_organisation
    @organisation = Organisation.find(params[:organisation_id])
  end

  def member
    User.find(params[:user_id])
  end
end

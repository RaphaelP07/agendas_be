class ApplicationController < ActionController::API
  before_action :authenticate_api_v1_user!
  
  private

  def get_organisation
    @organisation = Organisation.find(params[:organisation_id])
  end

  def member
    User.find(params[:user_id])
  end

  def not_admin
    not_admin = @organisation.admin != current_api_v1_user
  end
end

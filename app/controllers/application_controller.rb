class ApplicationController < ActionController::API
  before_action :authenticate_api_v1_user!
  before_action :member_is_not_in_org
  
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

  def member_is_not_in_org
    member_is_not_in_org = Organisation.find(
      params[:id] == nil ? return :
      params[:organisation_id] == nil ? params[:id] : 
      params[:organisation_id]
      ).users.exists?(current_api_v1_user['id']) == false
    
    if member_is_not_in_org
      render json: {
        message: 'You are not part of this organisation.'
      }, status: :method_not_allowed
    end
  end
end

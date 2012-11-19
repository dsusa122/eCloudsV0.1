class ConfirmationsController < Devise::ApplicationController

  require 'Devise'

  before_filter :authenticate_user!
  def show
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token])
    super if resource.confirmed?
  end

  def confirm
    self.resource = resource_class.find_by_confirmation_token(params[resource_name][:confirmation_token])
    if resource.update_attributes ( params[resource_name]) && resource.password_match?

             self.resource = resource_class.confirm_by_token(params[resource_name][:confirmation_token])
             set_flash_message :notice, :confirmed
             sign_ind_and_redirect(resource_name, resource)
    else
      render :action => "show"
    end
  end
end


class RegistrationsController < Devise::RegistrationsController
  def new
    flash[:notice] = 'Registrations are not open yet, but please check back soon'
    redirect_to root_path
  end

  def create
    flash[:notice] = 'Registrations are not open yet, but please check back soon'
    redirect_to root_path
  end

  def after_sign_up_path_for(resource)
    signed_in_root_path(resource)
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
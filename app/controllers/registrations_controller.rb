class RegistrationsController < Devise::RegistrationsController
  def new
    flash[:notice] = 'Registrations are not open yet, but please check back soon'
    redirect_to root_path
  end

  def create
    flash[:notice] = 'Registrations are not open yet, but please check back soon'
    redirect_to root_path
  end
end
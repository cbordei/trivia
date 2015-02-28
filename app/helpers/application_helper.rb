module ApplicationHelper
  def active_for(controller_name)
    params[:controller] == controller_name ? 'active' : ''
  end
end

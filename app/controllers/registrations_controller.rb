class RegistrationsController < Devise::RegistrationsController

  def after_update_path_for(scope)
    session[:referrer] ? session[:referrer] : root_path
  end

end

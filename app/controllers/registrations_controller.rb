class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_update_path_for(scope)
    session[:referrer] ? session[:referrer] : root_path
  end

private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:last_name, :first_name, :middle_name]
    devise_parameter_sanitizer.for(:account_update) << [:last_name, :first_name, :middle_name]
  end

end

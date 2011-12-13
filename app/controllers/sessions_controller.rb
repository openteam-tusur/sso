class SessionsController < Devise::SessionsController
  def after_sign_out_path_for(resource_or_scope)
    request[:redirect_uri]
  end
end


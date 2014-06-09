class SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource_or_scope)
    redirect_uri
  end

  def after_sign_out_path_for(resource_or_scope)
    request[:redirect_uri] || root_path
  end

  private
    def redirect_uri
      return params['redirect_uri'] if params['redirect_uri']

      url = if request.referer.try(:include?, 'redirect_uri=')
        Rack::Utils.parse_nested_query(URI.parse(request.referer).query).try(:[], 'redirect_uri')
      else
        request.env['rack.session']['omniauth.origin']
      end

      url ? url : root_path
    end
end


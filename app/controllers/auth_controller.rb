# encoding: utf-8

class AuthController < ApplicationController
  before_filter :authenticate_user_by_token!,    :only   => [:user]
  before_filter :authenticate_user!,             :except => [:access_token, :user]
  skip_before_filter :verify_authenticity_token, :only   => [:access_token]

  def welcome
    unless current_user.valid?
      flash[:error] = 'Внимание! Исправьте данные в профиле'
    end
  end

  def authorize
    AccessGrant.prune!
    welcome
    access_grant = current_user.access_grants.create({:client => application, :state => params[:state]}, :without_protection => true)
    session[:referrer] = access_grant.redirect_uri_for(params[:redirect_uri])
    redirect_to session[:referrer] if current_user.valid?
  end

  def access_token
    application = Client.authenticate(params[:client_id], params[:client_secret])

    if application.nil?
      render :json => {:error => "Could not find application"}
      return
    end

    access_grant = AccessGrant.authenticate(params[:code], application.id)
    if access_grant.nil?
      render :json => {:error => "Could not authenticate access code"}
      return
    end

    access_grant.start_expiry_period!
    render :json => {:access_token => access_grant.access_token, :refresh_token => access_grant.refresh_token, :expires_in => Devise.timeout_in.to_i}
  end

  def failure
    render :text => "ERROR: #{params[:message]}"
  end

  def user
    hash = {
      :provider => 'identity',
      :uid => current_user.id.to_s,
      :info => {
        :name => current_user.name,
        :email => current_user.email,
        :first_name => current_user.first_name,
        :last_name => current_user.last_name
      },
      :user => {
        :middle_name => current_user.middle_name
      }
    }
    render :json => hash.to_json
  end

  # Incase, we need to check timeout of the session from a different application!
  # This will be called ONLY if the user is authenticated and token is valid
  # Extend the UserManager session
  def isalive
    warden.set_user(current_user, :scope => :user)
    response = { 'status' => 'ok' }

    respond_to do |format|
      format.any { render :json => response.to_json }
    end
  end

  private

  def authenticate_user_by_token!
    access_token = params[:oauth_token].presence
    user         = access_token && User.find_by_access_token(access_token)
    sign_in user, :store => false if user
  end

  protected

  def application
    @application ||= Client.find_by_app_id(params[:client_id])
  end

end

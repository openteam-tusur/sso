class UsersController < ApplicationController
  def index
    render :json => User.search{ keywords params[:term] }.results.as_json(:only => :email, :methods => [:uid, :name])
  end
end

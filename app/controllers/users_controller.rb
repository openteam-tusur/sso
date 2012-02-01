class UsersController < ApplicationController

  inherit_resources
  has_searcher

  def index
    render :json => searcher.results.as_json(:only => :email, :methods => [:uid, :name])
  end

end

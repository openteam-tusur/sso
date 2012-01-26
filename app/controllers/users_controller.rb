class UsersController < ApplicationController

  inherit_resources
  has_searcher

  def index
    render :json => searcher.results
  end

end

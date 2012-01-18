class UsersController < ApplicationController
  inherit_resources

  actions :index

  has_searcher

  respond_to :json

  def index
    index!{ render :json => @users.to_json(:only => [:id, :email, :first_name, :last_name] ) and return}
  end

  protected
    def collection
      get_collection_ivar || set_collection_ivar(search_collection)
    end

    def search_collection
      searcher.results
    end
end

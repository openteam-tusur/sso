class UsersController < ApplicationController
  inherit_resources

  actions :index

  has_searcher

  respond_to :json

  protected
    def collection
      get_collection_ivar || set_collection_ivar(search_collection)
    end

    def search_collection
      searcher.results
    end
end

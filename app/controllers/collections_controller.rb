class CollectionsController < ApplicationController

  def index
    @collections = Collection.find(:all, :conditions => ['collection_title LIKE ?', "%#{params[:search]}%"])
  end

end
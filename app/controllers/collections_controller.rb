class CollectionsController < ApplicationController

  before_filter :authorize

  helper :movies_render

  def index
    @collections = Collection.find(:all, :conditions => ['collection_title LIKE ?', "%#{params[:search]}%"])
  end
  
  def show
    collection_id = params[:id].to_i
    @movies = Movie.find_all_by_collection_id(collection_id)
    @collection = Collection.find_by_id(collection_id)
  end
  
  def edit
    @collection = Collection.find(params[:id])
  end 
  
  def update
    begin
      @collection = Collection.find(params[:id])
      # save the collection
      @collection.attributes = params[:collection]
      @collection.save!
      flash[:notice] = 'Collection successfully edited!'
      redirect_to collection_path 
    rescue
      flash[:error] = 'An error occured during the editing of the collection!'
      render :action => 'edit'     
    end   
  end

end
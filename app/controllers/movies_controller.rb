class MoviesController < ApplicationController
  
  before_filter :authorize
  
  def index
    @movies = Movie.find(:all, :order => 'id DESC')
    @movies_users = @movies.group_by { |m| m.user.realname }
  end
  
  def show
    movie_id = params[:id].to_i
    @movie = Movie.find(movie_id)
  end
  
  def new
    @movie = Movie.new
    @collections = Collection.find(:all, :order => 'id ASC')
    @collections.insert(0, Collection.new(:collection_title => ''))
  end
  
  def create
    @movie = Movie.new(params[:movie])
    user = User.find_by_id session[:user_id]
    @movie.user_id = user.id
    
    if(params[:collection][:collection] != '' || params[:collection][:new_collection] != '')
      @collection = Collection.new
      if(params[:collection][:collection] != '')
        @collection.collection_title = params[:collection][:collection]
      elsif(params[:collection][:new_collection] != '')
        @collection.collection_title = params[:collection][:new_collection]
      end
      @collection.save!
      @movie.collection = @collection
    end
    
    @movie.save!
    flash[:notice] = 'Movie successfully created!' + session[:user_id].to_s + ' '
    redirect_to movies_path
  end  
  
  def edit
    movie_id = params[:id].to_i
    @movie = Movie.find(movie_id)
    @collections = Collection.find(:all, :order => 'id ASC')
    unless @movie.collection_id.nil?#
      # select the corresponding collection for the movie
      @collections.insert(0, Collection.new(:collection_title => ''))
      @collections.insert(0, @movie.collection)
    else
      # movie belongs to no collection, create a blank collection for it
      @collections.insert(0, Collection.new(:collection_title => ''))
    end
  end 
  
  def update
    @movie = Movie.find(params[:id])
    
    # movie has no collection associeted with
    if @movie.collection.nil?
      # the collection of the movie has been changed
      if(params[:collection][:collection] != '' && params[:collection][:new_collection] == '')
        @movie.collection = Collection.find_by_id(params[:collection][:collection])
      # a new but yet unknown collection will created
      elsif(params[:collection][:new_collection] != '')
        @collection = Collection.new
        @collection.collection_title = params[:collection][:new_collection]
        @collection.save!
        @movie.collection = @collection
      end
      
    # no new but yet unknown collection will be added
    elsif params[:collection][:new_collection] == ''
      @count_of_collection_referenced = Movie.find_all_by_collection_id(@movie.collection_id)
      # delete references to the collection, because no movie is referencing it anymore
      unless @count_of_collection_referenced.length > 1
        Collection.find_by_id(@movie.collection_id).destroy
      end
      if (params[:collection][:collection]) != ''
        @movie.collection = Collection.find_by_id(params[:collection][:collection])
      else
        @movie.collection = nil
      end
      
    # a new but yet unknown collection will be added
    elsif params[:collection][:new_collection] != ''
      @collection = Collection.new
      @collection.collection_title = params[:collection][:new_collection]
      @collection.save!
      @movie.collection = @collection
    end
    
    # save the movie
    if @movie.update_attributes(params[:movie])
      flash[:notice] = 'Movie successfully edited!'
    end 
    redirect_to movie_path     
  end
  
  def destroy
    @movie_to_destroy = Movie.find(params[:id])
    @movie_to_destroy.destroy
    flash[:notice] = 'Movie successfully deleted!'
    redirect_to movies_path
  end
end

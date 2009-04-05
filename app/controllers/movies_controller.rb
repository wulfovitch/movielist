class MoviesController < ApplicationController
  
  before_filter :authorize
  
  def index
    @movies = Movie.search(params[:search])
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
    @movie.save!
    flash[:notice] = 'Movie successfully created!' + session[:user_id].to_s + ' '
    redirect_to movies_path
  end  
  
  def edit
    @movie = Movie.find(params[:id])
  end 
  
  def update
    @movie = Movie.find(params[:id])
    
    # collection is changed or deleted
    if params[:movie][:collection_name] == '' || params[:movie][:collection_name] != @movie.collection.collection_title
      @count_of_collection_referenced = Movie.find_all_by_collection_id(@movie.collection_id)
      # delete references to the collection, because no movie is referencing it anymore
      unless @count_of_collection_referenced.length > 1
        Collection.find_by_id(@movie.collection_id).destroy
      end
      if params[:movie][:collection_name] == ''
        @movie.collection_id = nil # delete the reference to the collection
      elsif params[:movie][:collection_name] != @movie.collection.collection_title
        @movie.collection.collection_title = params[:movie][:collection_name] # update collection
      end
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

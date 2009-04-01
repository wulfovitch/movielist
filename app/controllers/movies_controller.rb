class MoviesController < ApplicationController
  
  before_filter :authorize
  
  def index
    @movies = Movie.find(:all, :order => 'id DESC')
  end
  
  def show
    movie_id = params[:id].to_i
    @movie = Movie.find(movie_id)
  end
  
  def new
  end
  
  def create
    if logged?
      @movie = Movie.new(params[:movie])
      user = User.find_by_id session[:user_id]
      @movie.user_id = user.id
      @movie.save!
      flash[:notice] = 'movie successfully created!' + session[:user_id].to_s + ' '
    end
    redirect_to movies_path
  end  
  
  def edit
    movie_id = params[:id].to_i
    @movie = Movie.find(movie_id)
  end 
  
  def update      
    @movie = Movie.find(params[:id])      
    if @movie.update_attributes(params[:movie])
      flash[:notice] = 'movie successfully edited'
    end 
    redirect_to movie_path     
  end
  
  def destroy
    if logged?
      @movie_to_destroy = Movie.find(params[:id])
      @movie_to_destroy.destroy
    end
    redirect_to movies_path
  end
end

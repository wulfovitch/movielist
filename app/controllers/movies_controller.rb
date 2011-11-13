class MoviesController < ApplicationController
  
  auto_complete_for :movie, :collection_name
  
  before_filter :authorize, :except => [:feed]
  before_filter :http_authenticate, :only => [:feed]
  
  helper :movies_render  
  
  def index
    @user = User.find_by_id session[:user_id]
    @movies = Movie.all
    
    collection_ids = []
    movies_to_be_removed = []
    for movie in @movies
      unless movie.collection_id.nil?
        collection_ids << movie.collection_id
      end
    end
    collection_ids.uniq!

    for movie in @movies
      unless movie.collection_id.nil?
        if collection_ids.include? movie.collection_id 
          collection_ids.delete movie.collection_id
        else
          movies_to_be_removed << movie
        end
      end
    end

    for movie in movies_to_be_removed
      @movies.delete(movie)
    end
    
    @movies_users = @movies.group_by { |m| m.user.realname }
  end
  
  def search
    @movies = Movie.search(params[:search])
  end
  
  def feed
    @movies = Movie.all(:order => 'ID DESC', :limit => 20)
  end
  
  def show
    begin
      @movie = Movie.find(params[:id].to_i)
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'Movie not found!'
      redirect_to root_url
    end
  end
  
  def new
    @movie = Movie.new
    @collections = Collection.all(:order => 'id ASC')
    @collections.insert(0, Collection.new(:collection_title => ''))
  end
  
  def create
    begin
      @movie = Movie.new(params[:movie])
      user = User.find_by_id session[:user_id]
      @movie.user_id = user.id
      
      set_collection
      set_purchase_date
      set_foreign_language
      
      @movie.save!
      flash[:notice] = 'Movie successfully created!'
      redirect_to movies_path
    rescue
      flash[:error] = 'An error occured during the creation of the movie!'
      render :action => 'new'
    end
  end  
  
  def edit
    @movie = Movie.find(params[:id])
  end 
  
  def update
    begin
      @movie = Movie.find(params[:id])
      @movie.attributes = params[:movie]

      set_collection
      set_purchase_date
      set_foreign_language
      
      @movie.save!
      flash[:notice] = 'Movie successfully edited!'
      redirect_to movie_path   
    rescue
      flash[:error] = 'An error occured during the editing of the movie!'
      render :action => 'edit'
    end  
  end
  
  def destroy
    @movie_to_destroy = Movie.find(params[:id])
    @movie_to_destroy.destroy
    flash[:notice] = 'Movie successfully deleted!'
    redirect_to movies_path
  end
  
  protected

    def http_authenticate
      authenticate_or_request_with_http_basic do |username, password|
        @user = User.authenticate(username, password)
      end
    end
    
    def set_collection
      # collection is changed or deleted
      if params[:movie][:collection_name] == '' || (params[:movie][:collection_name] != '' && @movie.collection_id.nil?) || params[:movie][:collection_name] != @movie.collection.collection_title
        @count_of_collection_referenced = Movie.find_all_by_collection_id(@movie.collection_id)
        # delete references to the collection, because no movie is referencing it anymore
        unless @count_of_collection_referenced.length > 1
          Collection.find(@movie.collection_id).destroy if @movie.collection_id
        end
        if params[:movie][:collection_name] == ''
          @movie.collection_id = nil # delete the reference to the collection
        elsif params[:movie][:collection_name] != ''
          collection = Collection.find_by_collection_title(params[:movie][:collection_name])
          if collection.blank?
            collection = Collection.new(:collection_title => params[:movie][:collection_name])
            collection.save!
          end
          @movie.collection = collection
        end
      end
    end
    
    def set_purchase_date
      if params[:movie][:bought_at].present?
        date_array = params[:movie][:bought_at].split("/") 
        @movie.bought_at = "#{date_array[2]}-#{date_array[1]}-#{date_array[0]} 00:00:00"
      else
        @movie.bought_at = "#{Time.now.localtime.strftime("%Y-%m-%d")} 00:00:00"
      end      
    end
    
    def set_foreign_language
      if params[:movie][:foreign_language] == ""
        @movie.foreign_language = nil
      end      
    end
end
class UsersController < ApplicationController
  
  before_filter :authorize, :except => [:login]  
  
  def login
    if logged?
      redirect_to movies_url
    else
      session[:user_id] = nil
      if request.post?      
        @user = User.authenticate(params[:username], params[:password])
        if @user
          session[:user_id] = @user.id
          redirect_to movies_url
        else
          flash[:error] = "Falsche Logindaten"
          redirect_to home_url
        end
      else
        #redirect_to :controller => 'welcome', :action => 'index'
      end
    end 
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "Du bist nun ausgeloggt"
    redirect_to home_url
  end
  
  def start
    @user = User.find_by_id session[:user_id]  
  end

end

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
          flash[:error] = "You have entered wrong login data!"
          redirect_to root_url
        end
      else
        #redirect_to root_url
      end
    end 
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "You are now logged off!"
    redirect_to root_url
  end
  
  def start
    @user = User.find_by_id session[:user_id]  
  end
  
  def togglegroupedview
    @user = User.find_by_id session[:user_id]
    if @user.show_grouped_by_user
      @user.show_grouped_by_user = false
    else
      @user.show_grouped_by_user = true
    end
    @user.save!
    redirect_to movies_url
  end

end

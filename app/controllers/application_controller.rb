class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def authorize
    user = User.find_by_id(session[:user_id])
    unless user
      flash[:error] = "You are not logged in! Please log in to continue!"
      redirect_to root_url
    else
      
    end
  end
  
  def logged?
    if session[:user_id]
      return true
    else
      return false
    end
  end
    
end

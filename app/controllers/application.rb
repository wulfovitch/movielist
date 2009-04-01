# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  #helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e758ecc93866bd35f5cc8fcc4a9568e6'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def authorize
    user = User.find_by_id(session[:user_id])
    unless user
      flash[:notice] = "Du bist nicht eingeloggt"
      redirect_to :controller => "welcome"
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
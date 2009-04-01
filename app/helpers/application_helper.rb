module ApplicationHelper
  
  def logged?
    if session[:user_id]
      return true
    else
      return false
    end
  end
  
  def is_active?(page_name, second_page_name = nil, third_page_name = nil)
    "class='selected'" if (params[:action] == page_name || params[:action] == second_page_name || params[:action] == third_page_name)
  end
  
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def stylesheet(file)
    content_for(:head) { stylesheet_link_tag(file) }
  end
  
end

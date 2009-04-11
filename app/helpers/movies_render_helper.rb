module MoviesRenderHelper 
  
  def show_movie movie
    
    return_string = "<h2>"
  	return_string +=	 link_to movie.movie_title, movie_url(movie) 
  	return_string += "</h2>"
  	return_string += "<hr style='border: 1px solid #000; margin-bottom: 6px;' />"
    
    return_string += "<p style='float: left; margin-right: 10px; margin-bottom: 20px; width: 310px;'>"
  	return_string +=	 link_to image_tag(movie.photo.url), movie.imdb_link
  	return_string += "</p>"
  	
  	return_string += "<p style='float: right;'>"
  	return_string += link_to("edit", edit_movie_path(movie)) + " | " + link_to("delete", movie_path(movie), { :method => 'delete', :confirm => 'really delete this movie?' })
  	return_string += "</p>"

  	return_string += "<p>"
  	return_string += "" + movie.created_at.strftime("%d.%m.%Y") + " - " + movie.user.realname
  	return_string += "</p>"
  	
  	unless movie.disc_type == ''
    	return_string += "<p>"
    	return_string +=    "disc type: " + movie.disc_type
    	return_string += "</p>"
    end

  	unless movie.media_type == ''
    	return_string += "<p>"
    	return_string +=	 "media type: " + movie.media_type
    	return_string += "</p>"
    end
    
   
  	
  	unless movie.parental_rating == ''
  	  return_string += "<p>"
  	  return_string +=	  "parental rating: " + movie.parental_rating
  	  return_string += "</p>"
	  end
	  
  	return_string += "<div style='clear: both;'></div>"
  	
  	return return_string
  end
  
end
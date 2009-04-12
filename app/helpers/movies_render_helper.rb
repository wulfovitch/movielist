module MoviesRenderHelper 
  
  def show_movie movie, collection_link = nil
    
    return_string = "<h3>"
  	return_string +=	 link_to movie.movie_title, movie_url(movie) 
  	return_string += "</h3>"
  	return_string += "<hr class='movie_seperator_line' />"
    
    return_string += "<p class='movie_picture'>"
  	return_string +=	 link_to image_tag(movie.photo.url), movie.imdb_link
  	return_string += "</p>"
  	
  	return_string += "<p style='float: right;'>"
  	return_string += link_to("edit", edit_movie_path(movie)) + " | " + link_to("delete", movie_path(movie), { :method => 'delete', :confirm => 'really delete this movie?' })
  	return_string += "</p>"

  	return_string += "<p>"
  	return_string += "" + movie.created_at.strftime("%Y-%m-%d") + " - " + movie.user.realname
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
	  
	  unless collection_link.nil?
	    return_string += "<p>"
	    return_string += "collection: " + link_to(movie.collection.collection_title, collection_url(movie.collection)) + image_tag('/images/icon_dvds.png')
	    return_string += "</p>"
	  end
	  
  	return_string += "<div style='clear: both;'></div>"
  	
  	return return_string
  end
  
end
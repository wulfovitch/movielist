module MoviesHelper 
  
  def show_movie movie
    return_string  = "<h2>"
  	return_string +=	 link_to movie.movie_title, movie_url(movie) 
  	return_string += "</h2>"

  	return_string += "<p>"
  	return_string +=	 image_tag movie.photo.url
  	return_string += "</p>"

  	return_string += "<p>"
  	return_string += "Bought <strong>" + movie.disc_type + "</strong> at: " + movie.created_at.strftime("%d.%m.%Y") +
  		" | " + link_to("edit", edit_movie_path(movie)) + " | " + link_to("delete", movie_path(movie), { :method => 'delete', :confirm => 'really delete this movie?' })
  	return_string += "</p>"

  	return_string += "<p>"
  	return_string +=	 link_to('imdb link', movie.imdb_link) + " / " + movie.media_type + " / parental rating: " + movie.parental_rating
  	return_string += "</p>"

  	return_string += "<p>"
  	return_string +=	  movie.user.username + "(" + movie.user.realname + ")"
  	return_string += "</p>"
  	
  	return return_string
  end
  
end
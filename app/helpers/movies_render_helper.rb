module MoviesRenderHelper 
  
  def show_movie movie, collection_link = nil
    
    return_string = "<h3>"
  	return_string <<  link_to(movie.movie_title, movie_url(movie))
  	return_string << "</h3>"
  	return_string << "<hr class='movie_seperator_line' />"
    
    return_string << "<p class='movie_picture'>"
  	return_string <<	 link_to(image_tag(movie.photo.url), movie.imdb_link)
  	return_string << "</p>"
  
  	return_string << "<p style='float: right;'>"
  	return_string << link_to("edit", edit_movie_path(movie)) + " | " + link_to("delete", movie_path(movie), { :method => 'delete', :confirm => 'really delete this movie?' })
  	return_string << "</p>"  	
  	
  	return_string << '<table class="movie_details">'
    return_string << '	<tr>'
  	return_string << '    <th>original Title:</th>'
  	return_string << '    <td>'+movie.movie_original_title+'</td>'
  	return_string << '  </tr>'
  	
  	unless movie.bought_at.nil?
    	return_string << '  <tr>'
    	return_string << '    <th>bought at:</th>'
    	return_string << '    <td>'+movie.formatted_bought_at+'</td>'
    	return_string << '  </tr>'
    end
    
    unless movie.foreign_language.nil?
    	return_string << '  <tr>'
    	return_string << '    <th>foreign language:</th>'
    	return_string << '    <td><img src="/images/flags/'+movie.foreign_language+'.png" /></td>'
    	return_string << '  </tr>'
    end
    
  	return_string << '  <tr>'
  	return_string << '    <th>owner:</th>'
  	return_string << '    <td>'+movie.user.realname+'</td>'
  	return_string << '  </tr>'
  	
  	unless movie.disc_type == ''
    	return_string << '  <tr>'
    	return_string << '    <th>disc type:</th>'
    	return_string << '    <td>'+movie.disc_type+'</td>'
    	return_string << '  </tr>'
    end
  	
  	unless movie.media_type == ''
    	return_string << '  <tr>'
    	return_string << '    <th>media type:</th>'
    	return_string << '    <td>'+movie.media_type+'</td>'
    	return_string << '  </tr>'
    end
  	
  	unless movie.parental_rating == ''
    	return_string << '  <tr>'
    	return_string << '    <th>parental rating:</th>'
    	return_string << '    <td>'+movie.parental_rating+'</td>'
    	return_string << '  </tr>'
    end
    
    unless collection_link.nil?
    	return_string << '  <tr>'
	    return_string << '    <th>belongs to collection:</th>'
	    return_string << '    <td>' + link_to(movie.collection.collection_title, collection_url(movie.collection)) + '</td>'
    	return_string << '  </tr>'
	  end
  	return_string << '</table>'
	  
  	return_string << "<div style='clear: both;'></div>"
  	return_string.html_safe
  end
  
end
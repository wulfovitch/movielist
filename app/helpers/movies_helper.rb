module MoviesHelper 
	
	def index_table user, movies, grouped_view
	  return_string = '<h4>' + user + ' (' + movies.length.to_s + ')</h4>'
		return_string << '<table width="100%" class="sortable" id="sortabletable_' + user  + '">'
		
		return_string << index_table_header(grouped_view)

		for movie in movies
		  return_string << index_table_content_row(movie, grouped_view)
		end

		return_string << '</table>'
	  return_string << '<br />'
	  return_string.html_safe
	end
	
	private
	
  	def index_table_header grouped_view
  	  return_string = '<tr>'
  		return_string	<< ' <th class="unsortable">&nbsp;</th>'
      return_string << ' <th>title</th>'
  		return_string	<< ' <th>original title</th>'
  		return_string	<< ' <th>purchase date</th>'
  		return_string	<< ' <th>media type</th>'
  		return_string	<< ' <th>parental rating</th>'
  		unless grouped_view
  		  return_string << ' <th>owner</th>'
  		end
      return_string << '</tr>'
      return_string
  	end
	
  	def index_table_content_row movie, grouped_view
  	  return_string = '<tr>'
  		return_string << '	<td>'
		
  		if movie.collection_id.nil?
  		  if movie.disc_type == 'bluray'
  		    return_string << link_to(image_tag('/images/icon_bluray.png'), movie.imdb_link)
  		  else
  		    return_string << link_to(image_tag('/images/icon_dvd.png'), movie.imdb_link)
  		  end
  		else
  		  if movie.disc_type == 'bluray'
  		    return_string << link_to(image_tag('/images/icon_blurays.png'), movie.imdb_link)
  		  else
  		    return_string << link_to(image_tag('/images/icon_dvds.png'), movie.imdb_link)
  		  end
  		end
		
  		return_string << '	</td>'
      return_string << '  <td>'
      
      unless movie.foreign_language.nil?
      	return_string << image_tag('/images/flags/'+movie.foreign_language+'.png', :alt => 'language: ' + movie.foreign_language) + '&nbsp;'.html_safe
      end
    
  		if movie.collection_id.nil?
  		  return_string << link_to(movie.movie_title, movie_url(movie))
  		else
  		  return_string << link_to(movie.collection.collection_title, collection_url(movie.collection))
  		end
		
  		return_string << '	</td>'
  		return_string << '	<td>'
		
  		if movie.collection_id.nil?
  		  return_string << '<i>' + link_to(movie.movie_original_title, movie_url(movie)) + '</i>'
  		else
  		  unless movie.collection.collection_original_title.nil?
  		    return_string << movie.collection.collection_original_title
  		  end
  		end
		
  		return_string << '	</td>'
  		return_string << '	<td>' + movie.formatted_bought_at + '</td>'
  		return_string << '	<td>' + movie.media_type + '</td>'
  		return_string << '	<td>' + movie.parental_rating + '</td>'
  		unless grouped_view
  		  return_string << '	<td>' + movie.user.realname + '</td>'
  		end
      return_string << '</tr>'
  	  return_string.html_safe
  	end
	
end
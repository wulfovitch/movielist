module MoviesHelper 
  
	def datechooser_input_field movie
	  movie_created = ""
	 	unless movie.created_at.nil?
			movie_created = @movie.created_at.strftime("%Y-%m-%d")
		end
		return '<input id="movie_created_at" name="movie[created_at]" class="datechooser dc-dateformat=\'Y-m-d\' dc-iconlink=\'/images/datechooser.png\' dc-weekstartday=\'1\' dc-startdate=\'' + Time.now.strftime("%m%d%Y") + '\' dc-latestdate=\'1231' + Time.now.strftime("%Y") + '\' dc-earliestdate=\'01012000\' type="text" value="' + movie_created + '">'
	end
	
	def index_table user, movies, grouped_view
	  return_string = '<h4>' + user + ' (' + movies.length.to_s + ')</h4>'
		return_string += '<table width="100%" class="sortable" id="sortabletable_' + user  + '">'
		
		return_string += index_table_header grouped_view

		for movie in movies
		  return_string += index_table_content_row movie, grouped_view
		end

		return_string += '</table>'
	  return_string += '<br />'
	end
	
	private
	
  	def index_table_header grouped_view
  	  return_string = '<tr>'
  		return_string	+= ' <th class="unsortable">&nbsp;</th>'
      return_string += ' <th>title</th>'
  		return_string	+= ' <th>original title</th>'
  		return_string	+= ' <th class="unsortable">imdb link</th>'
  		return_string	+= ' <th>purchase date</th>'
  		return_string	+= ' <th>media type</th>'
  		return_string	+= ' <th>disc type</th>'
  		return_string	+= ' <th>parental rating</th>'
  		unless grouped_view
  		  return_string += ' <th>owner</th>'
  		end
      return_string += '</tr>'
    
      return return_string
  	end
	
  	def index_table_content_row movie, grouped_view
  	  return_string = '<tr>'
  		return_string += '	<td>'
		
  		if movie.collection_id.nil?
  		  return_string += image_tag '/images/icon_dvd.png'
  		else
  		  return_string += image_tag '/images/icon_dvds.png'
  		end
		
  		return_string += '	</td>'
      return_string += '  <td>'
    
  		if movie.collection_id.nil?
  		  return_string += link_to movie.movie_title, movie_url(movie)
  		else
  		  return_string += link_to movie.collection.collection_title, collection_url(movie.collection)
  		end
		
  		return_string += '	</td>'
  		return_string += '	<td>'
		
  		if movie.collection_id.nil?
  		  return_string += '<i>' + link_to(movie.movie_original_title, movie_url(movie)) + '</i>'
  		else
  		  unless movie.collection.collection_original_title.nil?
  		    return_string += movie.collection.collection_original_title
  		  end
  		end
		
  		return_string += '	</td>'
  		return_string += '	<td>' + link_to('imdb link', movie.imdb_link) + '</td>'
  		return_string += '	<td>' + movie.created_at.strftime('%Y-%m-%d') + '</td>'
  		return_string += '	<td>' + movie.media_type + '</td>'
  		return_string += '	<td>' + movie.disc_type + '</td>'
  		return_string += '	<td>' + movie.parental_rating + '</td>'
  		unless grouped_view
  		  return_string += '	<td>' + movie.user.realname + '</td>'
  		end
      return_string += '</tr>'
	
  	  return return_string
  	end
	
end
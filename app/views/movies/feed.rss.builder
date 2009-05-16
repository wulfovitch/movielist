xml.instruct! :xml, :version=> "1.0" 
xml.rss :version=>"2.0" do
  xml.channel do
    xml.title "movie list"
    xml.description("movie list - keep track of your movie collection!")
    xml.link formatted_movie_url(:rss)
    
    for movie in @movies
      xml.item do
        unless movie.collection_id.nil?
          xml.title(movie.collection.collection_title)
          xml.description()                    
          xml.pubDate(movie.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
          xml.link collection_url(movie.collection)
          xml.guid collection_url(movie.collection)
        else
          xml.title(movie.movie_title)
          xml.description()                    
          xml.pubDate(movie.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
          xml.link movie_url(movie)
          xml.guid movie_url(movie)
        end
        
      end
    end
  end
end
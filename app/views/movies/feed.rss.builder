xml.instruct! :xml, :version=> "1.0" 
xml.rss :version=>"2.0" do
  xml.channel do
    xml.title "movie list"
    xml.description "movie list - keep track of your movie collection!"
    xml.link movies_url
    
    for movie in @movies
      xml.item do
        xml.title(movie.movie_title)
        xml.description(movie.movie_original_title)
        xml.pubDate(movie.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
        xml.link movie_url(movie)
        xml.guid movie_url(movie)
      end
    end
  end
end
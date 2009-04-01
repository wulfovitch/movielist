class Movie < ActiveRecord::Base
  
  belongs_to :user
  
  def to_param 
    "#{id}-#{movie_title.gsub(/[^a-z1-9]+/i, '-')}" 
  end  
  
end
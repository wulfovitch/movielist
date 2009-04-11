class Collection < ActiveRecord::Base

  has_many :movies
  
  def to_param 
    "#{id}-#{collection_title.downcase.gsub(/[^a-z1-9]+/i, '-')}" 
  end  
  
end
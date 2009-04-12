class Collection < ActiveRecord::Base

  has_many :movies
  
  validates_presence_of :collection_title
  
  def to_param 
    "#{id}-#{collection_title.downcase.gsub(/[^a-z1-9]+/i, '-')}" 
  end  
  
end
class Movie < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :collection
  
  has_attached_file :photo, :styles => { :original => "300x300>", :thumb => "100x100>" },
                    :url => "/uploads/photos/:id_:style.:extension",
                    :path => ":rails_root/public/uploads/photos/:id_:style.:extension",
                    :default_url => '/uploads/missing_:style.png'
  
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  def to_param 
    "#{id}-#{movie_title.downcase.gsub(/[^a-z1-9]+/i, '-')}" 
  end
  
  def self.search(search)
    if search
      find(:all, :conditions => ['movie_title OR movie_original_title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
  
  def collection_name
    collection.collection_title if collection
  end

  def collection_name=(name)
    self.collection = Collection.find_or_create_by_collection_title(name) unless name.blank?
  end
  
end
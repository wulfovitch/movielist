class Movie < ActiveRecord::Base
  
  validates_presence_of :movie_title
  
  attr_accessor :collection_name
  
  belongs_to :user
  belongs_to :collection
  
  has_attached_file :photo, :styles => { :original => "300>", :thumb => "100>" },
                    :url => "/uploads/photos/:id_:style.:extension",
                    :path => ":rails_root/public/uploads/photos/:id_:style.:extension",
                    :default_url => '/uploads/missing_:style.png'
  
  validates_attachment_size :photo, :less_than => 10.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  def to_param 
    "#{id}-#{movie_title.downcase.gsub(/[^a-z1-9]+/i, '-')}" 
  end
  
  def formatted_bought_at
    return bought_at.strftime("%Y/%m/%d") if bought_at.present?
    ''
  end
  
  def self.search(search)
    if search
      search = search.downcase
      all(:conditions => ['lower(movie_title) LIKE ? OR lower(movie_original_title) LIKE ?', "%#{search}%", "%#{search}%"], :order => 'created_at DESC')
      #find_by_sql(['SELECT distinct * FROM movies as m, collections as c
      #              WHERE (m.collection_id IS NULL
      #              OR m.collection_id = c.id)
      #              AND (m.movie_title OR m.movie_original_title OR c.collection_title LIKE ?)
      #              GROUP BY m.movie_title, c.collection_title', "%#{search}%"])
    else
      all
      #find_by_sql(['SELECT distinct * FROM movies as m, collections as c WHERE m.collection_id IS NULL OR m.collection_id = c.id GROUP BY m.movie_title'])
    end
  end
  
  def collection_name
    Collection.find(collection_id).collection_title if collection_id
  end  
  
end
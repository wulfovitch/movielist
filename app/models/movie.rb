class Movie < ActiveRecord::Base
  
  belongs_to :user
  
  has_attached_file :photo, :styles => { :original => "300x300>", :thumb => "100x100>" },
                    :url => "/uploads/photos/:id_:style.:extension",
                    :path => ":rails_root/public/uploads/photos/:id_:style.:extension",
                    :default_url => '/uploads/missing_:style.png'
  
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  def to_param 
    "#{id}-#{movie_title.gsub(/[^a-z1-9]+/i, '-')}" 
  end  
  
end
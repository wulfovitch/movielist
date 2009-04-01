require 'digest/sha1'

class User < ActiveRecord::Base

  has_many :movies
  
  def self.authenticate(username, password)
    user = self.find_by_username username        
    if user
      enc_password = Digest::SHA1.hexdigest(password)
      if user.hashed_password != enc_password
        user = nil
      end
    end
    user
  end
  
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    self.hashed_password = Digest::SHA1.hexdigest(self.password)
  end
  
end
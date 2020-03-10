class User < ActiveRecord::Base
  has_many(:games)
  has_secure_password
  
  #def games 
  #SQL query to get associated games goes here 
  #end 
  
  #has_secure_password is a macro
  #a macro is a method that write other methods for us 
  #in this case, instance methods 
  
  #@user.method
  
  #def authenticate(STRING )
  #HASHES THAT STRING AND COMPARES TO THAT PASSWORD_DIGEST ATTRIBUTE TO SEE IF THEY MATCH 
  #end
  
  #def password=(STRING)
  #HASHES THAT STRING AND SETS THE HASHED STRING AS THE PASSWORD_DIGEST ATTRIBUTE 
  #end 
  
  #def password 
  #end

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end
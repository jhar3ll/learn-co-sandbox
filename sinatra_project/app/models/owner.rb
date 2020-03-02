class Owner < ActiveRecord::Base
  has_many :games
  
  has_secure_password
  
  def slug 
    username.downcase.gsub(" ", "-")
  end 
  
  def self.find_by_slug(slug)
    Owner.all.find{|owner| owner.slug == slug}
  end 
end
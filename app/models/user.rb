class User < ActiveRecord::Base

  validates :name, :presence => true, :length => {:minimum => 1, :maximum => 40}
  validates :email, :uniqueness => true, 
                    :presence => true, 
                    :email => true, 
                    :length => {:minimum => 3, :maximum => 254}
  validates :password, :presence => true,
                       :length => {:minimum => 3, :maximum => 30}

  has_many :recipes
  has_many :comments
end

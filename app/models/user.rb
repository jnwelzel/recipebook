class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  
  has_friendly_id :name, :use_slug => true, :strip_non_ascii => true

  validates :name, :presence => true, :length => {:minimum => 1, :maximum => 40},
                   :uniqueness => true
                   
  validates :email, :uniqueness => true, 
                    :presence => true, 
                    :email => true, 
                    :length => {:minimum => 3, :maximum => 254}
                    
  validates :password, :presence => true,
                       :length => {:minimum => 3, :maximum => 30}

  has_many :recipes
  has_many :comments
end

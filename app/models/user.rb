class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :photo
  
  has_friendly_id :name, :use_slug => true, :strip_non_ascii => true
  has_attached_file :photo,
                    :default_url => "/images/default_user_picture.png",
                    :styles => {
                      :normal  => "128x128>",
                      :thumb => "50x50#" },
                    :default_style => :normal
                      
  validates_attachment_content_type :photo, :content_type => ["image/jpeg", "image/png", "image/gif"],
                                            :message => ": choose a valid format such as jpeg, png or gif."
                                            
  validates_attachment_size :photo, :less_than => 300.kilobytes,
                                    :message => ": file is too big, please keep it under 300kb"                                            

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

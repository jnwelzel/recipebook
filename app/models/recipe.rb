class Recipe < ActiveRecord::Base
  acts_as_taggable_on :tags
  
  validates :name, :presence => true,
                   :length => {:minimum => 3, :maximum => 60}
  validates :ingredients, :presence => true,
                   :length => {:minimum => 3, :maximum => 400}
  
  validates :instructions, :presence => true,
                   :length => {:minimum => 3, :maximum => 2048}                  
                   
  belongs_to :user
  has_many :comments, :dependent => :destroy
 
  has_attached_file :photo,
                    :default_url => "/images/default_recipe_picture.png",
                    :styles => {
                      :thumb=> "100x100#",
                      :normal  => "300x300>" },
                    :default_style => :normal
  
  validates_attachment_content_type :photo, :content_type => ["image/jpeg", "image/png", "image/gif"],
                                            :message => ": choose a valid format such as jpeg, png or gif."
                                            
  validates_attachment_size :photo, :less_than => 300.kilobytes,
                                    :message => ": file is too big, please keep it under 300kb"                                            
  
end

class Recipe < ActiveRecord::Base
  
  validates :name, :presence => true,
                   :length => {:minimum => 3, :maximum => 60}
  validates :ingredients, :presence => true,
                   :length => {:minimum => 3, :maximum => 400}
  
  validates :instructions, :presence => true,
                   :length => {:minimum => 3, :maximum => 2048}                  
                   
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :favorites
  has_many :favorees, :through => :favorites, :source => :user
 
  acts_as_taggable_on :tags
  
  acts_as_rateable

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
  
  searchable :auto_index => true, :auto_remove => true do
    text :name, :default_boost => 2.0
    text :description
    text :instructions
    text :ingredients
  end
  
  def to_s
    self.name
  end
end

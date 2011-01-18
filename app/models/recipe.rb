class Recipe < ActiveRecord::Base

  belongs_to :user
  has_many :tags
  
  validates :name, :presence => true,
                   :length => {:minimum => 3, :maximum => 60}
  validates :ingredients, :presence => true,
                   :length => {:minimum => 3, :maximum => 400}
  validates :instructions, :presence => true,
                   :length => {:minimum => 3, :maximum => 2048}                   
end

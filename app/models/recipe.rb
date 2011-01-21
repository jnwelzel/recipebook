class Recipe < ActiveRecord::Base
  
  validates :name, :presence => true,
                   :length => {:minimum => 3, :maximum => 60}
  validates :ingredients, :presence => true,
                   :length => {:minimum => 3, :maximum => 400}
  #rails generate migration add_instructions_to_recipes instructions:string
  validates :instructions, :presence => true,
                   :length => {:minimum => 3, :maximum => 2048}                  
                   
  belongs_to :user
  has_many :tags
  has_many :comments, :dependent => :destroy
  
  accepts_nested_attributes_for :tags, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  
end

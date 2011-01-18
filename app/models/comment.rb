class Comment < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user
  
  validates :body, :length => {:minimum => 3, :maximum => 254},
                   :presence => true
end

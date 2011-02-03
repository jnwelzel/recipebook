class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def index
    @tags = Recipe.tag_counts_on(:tags)
    $tags = @tags
  end
end

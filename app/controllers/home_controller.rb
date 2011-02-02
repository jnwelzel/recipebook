class HomeController < ApplicationController
  def index
    @tags = Recipe.tag_counts_on(:tags)
  end

end

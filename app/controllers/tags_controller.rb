class TagsController < ApplicationController

  def index
    @tags = current_user.recipes.tag_counts_on(:tags)
  end

  def show
    #@recipes = Recipe.tagged_with(params[:id], :on => :tags)
    @recipes = Recipe.tagged_with(params[:id], :on => :tags).where("user_id=?", current_user.id)
  end

end

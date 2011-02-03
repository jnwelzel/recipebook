class TagsController < ApplicationController

  def index
    if current_user
      @tags = current_user.recipes.tag_counts_on(:tags)
    else
      redirect_to "/"
    end
  end

  def show
    if current_user && !params[:global]
      @recipes = Recipe.tagged_with(params[:id], :on => :tags).where("user_id=?", current_user.id)
    else
      @recipes = Recipe.tagged_with(params[:id], :on => :tags)
    end
  end

end

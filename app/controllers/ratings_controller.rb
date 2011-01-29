class RatingsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:id])
    @recipe.rate_it(params[:recipe_rating], current_user.id)
    #@recipe.save
    flash[:notice] = "Recipe was successfully rated."
    redirect_to recipe_path(params[:id])
  end
end

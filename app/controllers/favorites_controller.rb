class FavoritesController < ApplicationController
  
  before_filter :authenticate_user!

  def index
    #assim eh menos eficiente, executa uma query pra cada favorito do cara
    #@user = User.find(current_user.id)
    #assim eh melhor, em uma unica query encontra os favoritos
    @favorites = Favorite.includes(:recipe).where("user_id = ?", current_user.id)
  end
  
  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    flash[:notice] = "Recipe was successfully removed from Favorites."
    redirect_to recipe_path(@favorite.recipe_id)
  end
  
  def create
    @favorite = Favorite.new :user_id => current_user.id, :recipe_id => params[:id]
    @favorite.save
    flash[:notice] = "Recipe was successfully added to Favorites."
    redirect_to recipe_path(params[:id])
  end
  
end

class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.create(params[:comment])
    redirect_to(recipe_path(@recipe), :notice => 'Comment was successfully added.')
  end
  
  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.destroy
      redirect_to(recipe_path(@recipe), :notice => 'Comment was successfully deleted.')
    else
      redirect_to(recipe_path(@recipe), :alert => 'You do not have permission to perform this operation.')
    end
  end

end

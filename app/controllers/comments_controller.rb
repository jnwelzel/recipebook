class CommentsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :authenticate_author, :only => :destroy

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.create(params[:comment])
    redirect_to(recipe_path(@recipe), :notice => 'Comment was successfully added.')
  end
  
  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.find(params[:id])
    
    @comment.destroy
    redirect_to(recipe_path(@recipe), :notice => 'Comment was successfully deleted.')
  end
  
  def authenticate_author
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.find(params[:id])
    if @comment.user_id != current_user.id
      redirect_to(recipe_path(@recipe), :alert => 'You do not have permission to perform this operation.')
    end
  end

end

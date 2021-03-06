class RecipesController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authenticate_author, :only => [:destroy, :edit, :update]

  # GET /recipes
  # GET /recipes.xml
  def index
    if(!params[:q].nil?)
      @hits = Recipe.solr_search do |s|
                   s.keywords params[:q]
                   s.paginate(:page => params[:page], :per_page => 5)
                 end
      render "solr_search_results"
    else
      @recipes = current_user.recipes
    end
  end

  # GET /recipes/1
  # GET /recipes/1.xml
  def show
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recipe }
    end
  end

  # GET /recipes/new
  # GET /recipes/new.xml
  def new
    @recipe = Recipe.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @recipe }
    end
  end

  # GET /recipes/1/edit
  def edit
    @recipe = Recipe.find(params[:id])
  end

  # POST /recipes
  # POST /recipes.xml
  def create
    @user = User.find(current_user.id)
    @recipe = @user.recipes.create(params[:recipe])
    
    redirect_to(@recipe, :notice => 'Recipe was successfully created.')
  end

  # PUT /recipes/1
  # PUT /recipes/1.xml
  def update
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        format.html { redirect_to(@recipe, :notice => 'Recipe was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.xml
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to(recipes_url, :notice => 'Recipe was successfully removed from Favorites.') }
      format.xml  { head :ok }
    end
  end
  
  #Impedir que usuarios mexam na receita de outros usuarios
  def authenticate_author
    @recipe = Recipe.find(params[:id])
    if @recipe.user_id != current_user.id
      redirect_to(recipe_path(@recipe), :alert => 'You do not have permission to perform this operation.')
    end
  end
end

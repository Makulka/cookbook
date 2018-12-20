class RecipesController < ApplicationController
    
   before_action :find_recipe, only: [:show]
   
    def index
        @recipes = Recipe.all
    end
    
    def show
        @creator = User.find(@recipe.creator_id)
    end
    
    def new
        @recipe = Recipe.new
    end
    
    def edit
    end
    
    def create
        @recipe = Recipe.new(recipe_params)
        @recipe.creator_id = current_user.id
        if @recipe.save
            @user_recipe = UserRecipe.create(user: current_user, recipe: @recipe )
            flash[:success] = "Your recipe was created"
            redirect_to recipe_path(@recipe)
        else
            render "new"
        end
    end
    
    # def destroy
    #     @article.destroy
    #     flash[:danger] = "Article was successfully deleted"
    #     redirect_to articles_path
    # end
    
    def search
        if params[:search_param].blank?
          flash.now[:danger] = "You have entered an empty search string"
        else
          @recipes = Recipe.search(params[:search_param])
          flash.now[:danger] = "No users match this search criteria" if @recipes.blank?
        end
        respond_to do |format|
          format.js { render partial: 'user_recipes/result' }
        end
    end
    
    private
    
    def recipe_params
        params.require(:recipe).permit(:title, :description, :creator_id)
    end
    
    def find_recipe
        @recipe = Recipe.find(params[:id])
    end
end
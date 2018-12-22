class RecipesController < ApplicationController
    
   before_action :find_recipe, only: [:show, :edit, :update]
   before_action :require_creator_or_admin, only: [:edit, :update]
   before_action :require_user, only: [:new, :create]
   
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
            #@user_recipe = UserRecipe.create(user: current_user, recipe: @recipe )
            flash[:success] = "Your recipe was created"
            redirect_to recipe_path(@recipe)
        else
            render "new"
        end
    end
    
    def update
        if @recipe.update(recipe_params)
            flash[:success] = "Recipe was successfully edited"
            redirect_to recipe_path(@recipe)
        else
            render "edit"
        end
    end
   
    def search
        if params[:search_param].blank?
          flash.now[:danger] = "Oops, we did could find nothing. Try searching for something"
        else
          @recipes = Recipe.search(params[:search_param])
          flash.now[:danger] = "No recipe with your search criteria was found" if @recipes.blank?
        end
        respond_to do |format|
          format.js { render partial: 'user_recipes/result' }
        end
    end
    
    private
    
    def recipe_params
        params.require(:recipe).permit(:title, :description, :ingredients, :steps, :link, :creator_id, category_ids: [])
    end
    
    def find_recipe
        @recipe = Recipe.find(params[:id])
    end
    
    def require_creator_or_admin
        if @recipe.creator_id != current_user.id and !current_user.admin?
            flash[:danger] = "Sorry, you cannot perform this action as you did not create this recipe"
            redirect_to root_path
        end
    end
    
end



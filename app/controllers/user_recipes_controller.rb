class UserRecipesController < ApplicationController
    
    def new
    end
    
    def create
        @recipe = Recipe.find(params[:recipe])
        current_user.user_recipes.build(recipe_id: @recipe.id)
        if current_user.save
            flash[:notice] = "Recipe was successfully added"
        else
            flash[:danger] = "There was something wrong with the recipe request"
        end  
        redirect_to user_path(current_user)
    end
    
    def destroy
        @recipe = current_user.user_recipes.where(recipe_id: params[:id]).first
        @recipe.destroy
        flash[:notice] = "The recipe was successfully removed from your list"
        redirect_to user_path(current_user)
    end
    
    
end
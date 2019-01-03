class CategoriesController < ApplicationController
    
    def show
        @category = Category.find(params[:id])
        @category_recipes = @category.recipes
    end
end
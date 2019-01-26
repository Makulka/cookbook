class CommentsController < ApplicationController
    
    before_action :require_user
    before_action :find_recipe
    
    def create
        #@comment = @recipe.comments.build(comment_params) - this cannot be used with validations in the model
        @comment = Comment.new(comment_params)
        @comment.recipe_id = @recipe.id
        @comment.user_id = current_user.id
        if @comment.save
            flash.now[:success] = "Thank you for your comment."
        else 
            flash.now[:danger] = "Please enter a comment containing 1-300 characters."
        end
        #redirect_to @recipe
        respond_to do |format|
          format.js { render partial: 'comments/comment' }
        end
    end
    
    def destroy
        
        @comment = Comment.find(params[:id])
        @comment.destroy
        flash.now[:success] = "Your comment was deleted."
        #redirect_to @recipe
        respond_to do |format|
          format.js { render partial: 'comments/comment' }
        end
    end
    
    private
    def comment_params
        params.require(:comment).permit(:body, :rating) 
    end
    
    def find_recipe
        @recipe = Recipe.find(params[:recipe_id])
    end
end

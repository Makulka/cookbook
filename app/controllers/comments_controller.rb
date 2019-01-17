class CommentsController < ApplicationController
    
    before_action :require_user
    
    def create
        @recipe = Recipe.find(params[:recipe_id])
        @comment = @recipe.comments.build(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
            flash[:success] = "Thank you for your comment."
        else 
            flash[:danger] = "Please enter a comment before submitting it."
        end
        redirect_to @recipe
    end
    
    
    private
    def comment_params
        params.require(:comment).permit(:body) 
    end
end

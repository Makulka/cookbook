class CommentsController < ApplicationController
    
    before_action :require_user
    
    def create
        @recipe = Recipe.find(params[:recipe_id])
        @comment = @recipe.comments.build(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
            flash.now[:success] = "Thank you for your comment."
        else 
            flash.now[:danger] = "Please enter a comment before submitting it."
        end
        #redirect_to @recipe
        respond_to do |format|
          format.js { render partial: 'comments/comment' }
        end
    end
    
    private
    def comment_params
        params.require(:comment).permit(:body) 
    end
end

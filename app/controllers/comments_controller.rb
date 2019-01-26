class CommentsController < ApplicationController
    
    before_action :require_user
    before_action :find_recipe
    before_action :find_comment, only: [:destroy]
    before_action :require_creator_or_admin, only: [:destroy]
    
    def create
        #@comment = @recipe.comments.build(comment_params) - this cannot be used with validations in the model
        @comment = Comment.new(comment_params)
        @comment.recipe_id = @recipe.id
        @comment.user_id = current_user.id
        if @comment.save
            flash.now[:success] = "Thank you for your comment."
        else 
            flash.now[:danger] = "Please rate the recipe and enter a comment containing 1-300 characters."
        end
        #redirect_to @recipe
        respond_to do |format|
          format.js { render partial: 'comments/comment' }
        end
    end
    
    def destroy
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
    
    def find_comment
        @comment = Comment.find(params[:id])
    end
    
    def require_creator_or_admin
        if @comment.user_id != current_user.id and !current_user.admin?
            flash[:danger] = "Sorry, you cannot perform this action as you did not create this comment"
            redirect_to @recipe
        end
    end
end

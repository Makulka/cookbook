class UsersController < ApplicationController
    
    before_action :find_user, only: [:show, :edit, :update, :destroy]
    before_action :logged_in_redirect, only: [:new, :create]
    before_action :require_user, except: [:new, :create]
    before_action :require_same_user_or_admin, only: [:edit, :update, :destroy]
    
    def index
    end
    
    def show
        @recipes = Recipe.find_created_recipes(@user.id)
    end
    
    def edit
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Wellcome to the Cookbook #{@user.username}"
            redirect_to user_path(@user)
        else
            render "/home/index"
        end
    end
    
    def update
        if @user.update(user_params)
            flash[:success] = "Your account was successfully edited"
            redirect_to user_path(@user)
        else
            render "edit"
        end
    end
    
    def destroy
        @user.destroy
        flash[:danger] = "Your account was deleted"
        redirect_to users_path
    end
    
    
    
    private
    
    def user_params
       params.require(:user).permit(:username, :email, :password) 
    end
    
    def find_user
        @user = User.find(params[:id])
    end
    
    def require_same_user_or_admin
        if current_user != @user and !current_user.admin?
            flash[:danger] = "Sorry, you cannot perform this action"
            redirect_to root_path
        end
    end
    
    
end
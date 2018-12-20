class SessionsController < ApplicationController
    
    before_action :logged_in_redirect, only: [:new, :create]
    
    def new
    end
    
    def create
        user = User.find_by(username: params[:session][:username])
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id 
            flash[:success] = "You have successfully logged in"
            redirect_to user_path(user)
        else
            flash.now[:error] = "there was something wrong with your log in"
            @user = User.new
            render "home/index"
        end
    end
    
    def destroy
        session[:user_id] = nil
        flash[:success] = "You have successfully logged out"
        redirect_to root_path
    end
    
    private
    def logged_in_redirect
        if logged_in?
            flash[:error] = "You are already logged in"
            redirect_to user_path(user) 
        end
    end
    
end
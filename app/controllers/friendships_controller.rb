class FriendshipsController < ApplicationController

    before_action :require_user
    
    def new
    end
    
    def create
        @friend = User.find(params[:friend])
        current_user.friendships.build(friend_id: @friend.id)
        if current_user.save
            flash[:success] = "Freind was successfully added"
        else
            flash[:danger] = "There was something wrong with the friend request"
        end  
        redirect_to user_path(current_user)
    end
    
    def destroy
        @friendship = current_user.friendships.where(friend_id: params[:id]).first
        @friendship.destroy
        flash[:notice] = "Friend was successfully removed"
        redirect_to my_friends_path
    end
    
end
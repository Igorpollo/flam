class UserFollowersController < ApplicationController
  before_filter :authenticate_user!, only: [:new]
  
  def teste
     render nothing: true
     
  
      if params[:query]
        @friend = User.where(id: params[:query]).first
        @user_follower = current_user.user_followers.create(follower: @friend)
      else
        flash[:error] = "Friend required"
      end
   
    
  end
  
  def destroy
    render nothing: true
    @followers = current_user.user_followers.find(params[:query])
    @followers.destroy
  end
  
  def show
    
  end
  
  def new
    @followers = current_user.followers.all
    
    if params[:query]
        @friend = User.where(id: params[:query]).first
        @user_follower = current_user.user_followers.create(follower: @friend)
      else
        flash[:error] = "Friend required"
      end
    
  end
end

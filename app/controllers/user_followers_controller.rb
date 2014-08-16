class UserFollowersController < ApplicationController
  before_filter :authenticate_user!, only: [:new]

  
def new

    if request.get?
      render file: 'public/404.html' 
    else

    render nothing: true
   
        @user = User.find_by_profile_name(params[:id])
        @user_follower = current_user.user_followers.create(follower: @user.id)

    end
  
  end
  
  def destroy
    render nothing: true
    @user = User.find_by_profile_name(params[:id])
    @followers = current_user.user_followers.where(follower_id: @user.id)
    @followers.destroy_all

  end
  
  def show
    
  end
  
end

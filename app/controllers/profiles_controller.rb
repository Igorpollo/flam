class ProfilesController < ApplicationController
  def show

  	@user = User.find_by_profile_name(params[:id])
  	@photos = @user.photos.all

  	if @user
  		@clientes = @user.clientes.all
  		render action: :show
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end

  end

  def follow
  	render nothing: true

  	if request_method == 'DELETE'
  		@friend = User.where(id: params[:user_id]).first
  		@user_follower = current_user.user_followers.create(follower: @friend)
  	else
  	  if params[:user_id]
        @friend = User.where(id: params[:user_id]).first
        @user_follower = current_user.user_followers.create(follower: @friend)
      else
        flash[:error] = "Friend required"
      end
    end
  end

end

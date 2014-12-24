class ProfilesController < ApplicationController
  
  def show
  	@user = User.find_by_profile_name(params[:id])
  	@photos = @user.photos.all.reverse

  	if @user
  		@clientes = @user.clientes.all
  		render action: :show
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end
  end

  def edit
    # For Rails 4
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    # For Rails 3
    # account_update_params = params[:user]

    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
      account_update_params.delete("current_password")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  def like

    if (params[:photo_id])
     @photo = Photo.friendly.find(params[:photo_id])
     @like = current_user.likes.create(photo_id: @photo.id)
     #Add reputation for owner
     @user = User.find(@photo.user_id)
    @user.reputation = @user.reputation + 0.5
    @user.save
    #Add reputation for user
    current_user.reputation = current_user.reputation + 0.2
    current_user.save
     respond_to do |format|
        format.json { render :json => @photo.likes.count }
     end
    else
      render file: 'public/404.html'
    end
  end

  def dislike
     @photo = Photo.friendly.find(params[:photo_id])
     @like = current_user.likes.where(photo_id: @photo.id)
     @like.destroy_all
     #Remove reputation
     @user = User.find(@photo.user_id)
    @user.reputation = @user.reputation - 0.5
    @user.save
     respond_to do |format|
      format.json { render :json => @photo.likes.count }
     end
  end


   def favorite

    if (params[:photo_id])
     @photo = Photo.find(params[:photo_id])
     @like = current_user.favorites.create(photo_id: @photo.id)
     #Add Reputation for owner
      @user = User.find(@photo.user_id)
      @user.reputation = @user.reputation + 0.8
      @user.save
      #Add Reputation for current_user

    current_user.reputation = current_user.reputation + 0.3
    current_user.save
     respond_to do |format|
        format.json { render :json => @photo.favorites.count }
     end
    else
      render file: 'public/404.html'
    end
  end

  def unfavorite
     @photo = Photo.friendly.find(params[:photo_id])
     @like = current_user.favorites.where(photo_id: @photo.id)
     @like.destroy_all
     #Remove reputation
     @user = User.find(@photo.user_id)
    @user.reputation = @user.reputation - 0.8
    @user.save
     respond_to do |format|
      format.json { render :json => @photo.favorites.count }
     end
  end



private

def like_params
      params.permit(:photo_id, :user_id)
end
  
end

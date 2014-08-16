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

  def like

    if (params[:photo_id])
     @photo = Photo.friendly.find(params[:photo_id])
     @like = current_user.likes.create(photo_id: @photo.id)
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
     respond_to do |format|
      format.json { render :json => @photo.likes.count }
     end
  end


   def favorite

    if (params[:photo_id])
     @photo = Photo.friendly.find(params[:photo_id])
     @like = current_user.favorites.create(photo_id: @photo.id)
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
     respond_to do |format|
      format.json { render :json => @photo.favorites.count }
     end
  end



private

def like_params
      params.permit(:photo_id, :user_id)
end
  
end

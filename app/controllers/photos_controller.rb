class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  
  before_filter :authenticate_user!, only: [:create, :new, :update, :destroy, :edit]
  before_filter :find_user
  
 # skip_before_filter :verify_authenticity_token

  # GET /photos
  # GET /photos.json
  def index
    @photos = current_user.photos.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    
    params[:profile_name] = current_user
    @photo = current_user.photos.new
  end

  def flow
    @user = current_user
    @photos = Photo.all.order(id: :desc)
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create

     if(params[:token])
        @photoEdit = current_user.photos.last
        @photoEdit.update(photo_params)
      else
        @photo = current_user.photos.create(photo_params)
        render :text => 'title'
      end
    
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if current_user.photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end
  
  def url_options
    { profile_name: params[:profile_name] }.merge(super)
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = current_user.photos.find(params[:id])
    end
    
    def find_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:album_id, :user_id, :title, :description, :path, :photo_token)
    end
end

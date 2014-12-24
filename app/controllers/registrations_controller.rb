class RegistrationsController < Devise::RegistrationsController

  def edit
    if(params[:profile_name])
      if User.exists?(:profile_name => params[:profile_name])
        respond_to do |format|
        format.json { render :json => true }
        end
      else
        respond_to do |format|
        format.json { render :json => false }
        end
      end  
    else
    render layout: "clean"
    end
  end
  def update
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
end
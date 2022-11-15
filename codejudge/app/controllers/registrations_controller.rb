class RegistrationsController < ApplicationController
  layout "welcome"

  # instantiates new user
  def new
    @user = User.new
  end
  def create
    unless flash[:google_sign_in].nil?
      @user = sign_up_with_google
    else
      @user = User.new(user_params)      
      @assignment = Assignment.new

      if user_params_2 == "Instructor"
        @assignment.role_id = 2
      else 
        @assignment.role_id = 4
      end
    end

    if @user.save
      @assignment.user_id = User.find_by(username: user_params[:username]).id
      if @assignment.save
        redirect_to root_path, notice: 'Successfully created account'
      end
    else
      render :new
    end
  end

  private
  def user_params
    # strong parameters
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :firstname, :lastname)
  end

  def user_params_2
    params.require(:logintype)
  end

  def sign_up_with_google
    if id_token = flash[:google_sign_in]["id_token"]
      params = GoogleSignIn::Identity.new(id_token)
      User.new(firstname: params.given_name, lastname: params.family_name, username: params.email_address, email: params.email_address, google_id: params.user_id )
    elsif error = flash[:google_sign_in][:error]
      logger.error "Google authentication error: #{error}"
      nil
    end
  end
end
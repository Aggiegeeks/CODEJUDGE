class RegistrationsController < ApplicationController
  layout "welcome"

  # instantiates new user
  def new
    @user = User.new
  end

  def create
    @assignment = Assignment.new
    unless flash[:google_sign_in].nil?
      @user = sign_up_with_google
    else
      @user = User.new
      @user.firstname = user_params[:firstname]  
      @user.lastname = user_params[:lastname]   
      @user.email = user_params[:email]   
      @user.username = user_params[:username]   
      @user.password = user_params_3
      @user.password_confirmation = user_params_4   

      @assignment = Assignment.new
      if user_params_2 == "Instructor"
        @assignment.role_id = 2
      else 
        @assignment.role_id = 4
      end
    end
    if @user.save
      puts "helooooo"
      @assignment.user_id = User.find_by(username: user_params[:username]).id
      puts "chaloooo"
      puts @assignment.user_id
      if @assignment.save!
        puts "asdf"
        redirect_to root_path, notice: 'Successfully created account'
      else
       render :new
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

  def user_params_3
    params.require(:password)
  end

  def user_params_4
    params.require(:password_confirmation)
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
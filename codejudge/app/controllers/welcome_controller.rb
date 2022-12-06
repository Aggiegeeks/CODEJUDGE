class WelcomeController < ApplicationController
  def index
    unless current_user.nil?
      redirect_to problems_path
    end
  end

  def log_in
    logged_in = false

    unless flash[:google_sign_in].nil?
      if user = sign_in_with_google
        logged_in = true
      else
        redirect_to root_path, notice: "Login with Google failed"
      end
    else
      puts "checking....."
      puts params[:username]
      user = User.find_by(username: params[:username])
      if user.present? && user.authenticate(params[:password])
        logged_in = true
      else
        redirect_to root_path, notice: "Incorrect username or password"
      end
    end

    if logged_in
      cookies.signed[:user_id] = user.id
      session[:user_id] = user.id
      role = Assignment.find_by(user_id: User.find_by(username: params[:username]).id).role_id
      puts 'printing'
      puts role
      if role == 1
        redirect_to admins_path, notice: 'Logged in admin successfully'
      end
      if role == 2
        redirect_to instructors_path, notice: 'Logged in instructor successfully'
      end
      if role == 4
          redirect_to problems_path, notice: 'Logged in student successfully'
      end
    end
  end

  def log_out
    # deletes user session
    cookies.delete(:user_id)
    cookies.delete(:_codejudge_session)
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged Out'
  end

  private
    def sign_in_with_google
      if id_token = flash[:google_sign_in]["id_token"]
        User.find_by google_id: GoogleSignIn::Identity.new(id_token).user_id
      elsif error = flash[:google_sign_in][:error]
        logger.error "Google authentication error: #{error}"
        nil
      end
    end
end

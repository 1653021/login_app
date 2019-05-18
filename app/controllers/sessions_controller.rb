class SessionsController < ApplicationController
    def new
        
    end

    def create
        user = User.find_by(name: params[:session][:name])
        #render plain: params[:session][:password].inspect
        if user && user.authenticate(params[:session][:password])
        # Log the user in and redirect to the user's show page.
        sessions[:user_id] = user.id
        flash[:success] = "Login success"
        redirect_to user  
        else
        # Create an error message.
        flash[:danger] = 'Invalid email/password combination' # Not quite right!
        render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "You are logged out"
        redirect_to login_path
    end

    private def user_name_params
        params.require(:user).permit(:name)
    end

    def match_password(login_password="")
        encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
    end
end

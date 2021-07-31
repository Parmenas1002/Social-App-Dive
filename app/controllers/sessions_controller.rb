class SessionsController < ApplicationController
    skip_before_action :login_required, only: [:new, :create]
    def new
    end
    def create
        user = User.find_by(email: params[:session][:email])
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            redirect_to posts_path, notice: "Happy to see you again #{user.name}"
        else
            flash.now[:danger] = "Login Failed"
            render :new
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to new_session_path, notice: "Logout success"
    end
end

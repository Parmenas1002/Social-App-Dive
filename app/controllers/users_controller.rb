class UsersController < ApplicationController
    skip_before_action :login_required, only: [:new, :create]
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to posts_path, notice: "Welcome #{@user.name}"
        else
            render :new
        end
    end
    def show
        @user = User.find(params[:id])
    end
    private
    def user_params
        params.require(:user).permit(:name,:email, :password, :password_confirmation)
    end
end

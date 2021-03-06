class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_param)

    if(@user.save)
      redirect_to @user
    else
      render 'new'
    end
  end

  def user_param
    params.require(:user).permit(:name, :password)
  end 

end

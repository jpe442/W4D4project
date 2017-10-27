class UsersController < ApplicationController

  before_action :require_logged_out, only: [:create, :new]
  before_action :require_logged_in, only: [:update]

  def new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def update
    @user = User.find_by(user_params)
    @user.update(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end

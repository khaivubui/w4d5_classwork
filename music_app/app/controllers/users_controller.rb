class UsersController < ApplicationController
  before_action :ensure_logged_in, except: [:new, :create]

  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to '/'
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
end

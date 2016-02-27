class Admin::UsersController < ApplicationController
  layout "admin/application"
  before_action :authenticate_user!
  before_action :admin_user, except: [:index]
  before_action :find_user_by_params, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: Settings.per_page)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    @user.save
    @users = User.all
    flash.now[:notice] = flash_message("created")
  end

  def edit
  end

  def update
    @user.update_attributes user_params
    @users = User.all
    flash.now[:notice] = flash_message("updated")
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: flash_message("deleted")
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation,
      :admin
  end

  def find_user_by_params
    @user = User.find params[:id]
  end
end

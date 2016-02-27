class Admin::ProfilesController < ApplicationController
  layout "admin/application"
  before_action :authenticate_user!
  before_action :find_user_by_params, only: [:show, :edit, :update]
  before_action only: [:edit, :update] do
    correct_user? @user
  end

  def show
  end

  def edit
  end

  def update
    @user.update_with_password user_params
    flash.now[:notice] = flash_message("updated")
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :current_password, :avatar,
      :avatar_cache
  end

  def find_user_by_params
    @user = User.find params[:id]
  end
end

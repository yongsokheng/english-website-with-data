class Admin::PasswordsController < ApplicationController
  layout "admin/application"
  before_action :authenticate_user!
  before_action :get_current_user, only: [:edit, :update]
  before_action only: [:edit, :update] do
    correct_user? @user
  end

  def edit
  end

  def update
    user = @user.update_with_password user_params
    if user
      js_redirect_to new_user_session_path
    end
  end

  private
  def user_params
    params.require(:user).permit :current_password, :password, :password_confirmation
  end

  def get_current_user
    @user = current_user
  end

  def js_redirect_to path
    render js: %(window.location.href='#{path}') and return
  end
end

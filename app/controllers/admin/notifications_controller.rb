class Admin::NotificationsController < ApplicationController
  layout "admin/application"
  before_action :authenticate_user!

  def index
    @notifications = Notification.paginate(page: params[:page], per_page: Settings.per_page)
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = current_user.notifications.new notification_params
    @notification.save
    @notifications = Notification.all
    flash.now[:notice] = flash_message("created")
  end

  def destroy
    Notification.find(params[:id]).destroy
    redirect_to admin_notifications_path, notice: flash_message("deleted")
  end

  private
  def notification_params
    params.require(:notification).permit :content, :link
  end
end

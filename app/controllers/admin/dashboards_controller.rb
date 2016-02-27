class Admin::DashboardsController < ApplicationController
  layout "admin/application"
  before_action :authenticate_user!

  def index
    @user_number = User.count
    @category_number = Category.count
    @article_number = Article.count
    @device_number = Device.count
    @notification_number = Notification.count
    @draft_number = Article.draft.count
    @pending_number = Article.pending.count
    @published_number = Article.published.count
    @trash_number = Article.only_deleted.count
  end
end

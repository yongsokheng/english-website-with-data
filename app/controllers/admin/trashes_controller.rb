class Admin::TrashesController < ApplicationController
  layout "admin/application"
  before_action :authenticate_user!
  before_action :find_trash_params, only: [:destroy]
  before_action :admin_or_correct_user, only: [:destroy]

  def index
    @search = Article.only_deleted.search params[:q]
    @articles = @search.result
      .paginate(page: params[:page], per_page: Settings.per_page)
      .order("created_at DESC")
  end

  def edit
    Article.restore params[:id]
    redirect_to request.referrer || root_url, notice: t("flashs.messages.restore")
  end

  def destroy
    @article.really_destroy!
    redirect_to request.referrer || root_url, notice: t("flashs.messages.delete_permanently")
  end

  private
  def find_trash_params
    @article = Article.only_deleted.find params[:id]
  end

  def admin_or_correct_user
    redirect_to admin_root_path unless current_user.admin? || correct_user?(@article.user)
  end
end

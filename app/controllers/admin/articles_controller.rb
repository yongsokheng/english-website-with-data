class Admin::ArticlesController < ApplicationController
  layout "admin/application"
  before_action :authenticate_user!
  before_action :get_article_status, only: [:create, :update]
  before_action :find_article_by_params, only: [:edit, :update, :destroy]
  before_action only: [:edit, :update] do
    correct_user? @article.user
  end
  before_action :admin_or_correct_user, only: [:destroy]

  def index
    @search = Article.search params[:q]
    @articles = @search.result
      .paginate(page: params[:page], per_page: Settings.per_page)
      .order("created_at DESC")
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new article_params
    if Settings.commit.preview == params[:commit]
      render "articles/preview"
    elsif @article.save
      redirect_to admin_articles_path, notice: flash_message("created")
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if Settings.commit.preview == params[:commit]
      render "articles/preview"
    elsif @article.update_attributes article_params
      redirect_to admin_articles_path, notice: flash_message("created")
    else
      render "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to request.referrer || root_url, notice: t("flashs.messages.move_to_trash")
  end

  private
  def article_params
    params.require(:article).permit :title, :content, :image, :image_cache,
      :audio_url, :post_status, :category_id, :schedule_at, :published_at
  end

  def get_article_status
    commit = params[:commit]

    if Settings.commit.save_draft == commit
      params[:article][:post_status] = Settings.post_status.draft
      params[:article][:schedule_at] = ""
    elsif Settings.commit.publish == commit
      params[:article][:post_status] = Settings.post_status.published
      params[:article][:schedule_at] = ""
      params[:article][:published_at] = Time.zone.now
    elsif Settings.commit.schedule == commit
      params[:article][:post_status] = Settings.post_status.pending
    elsif Settings.commit.unpublish == commit
      params[:article][:post_status] = Settings.post_status.draft
      params[:article][:published_at] = ""
    elsif Settings.commit.preview == commit
      params[:article][:published_at] = Time.zone.now
    end
  end

  def find_article_by_params
    @article = Article.find params[:id]
    @article_state = Article.find params[:id]
  end

  def admin_or_correct_user
    redirect_to admin_root_path unless current_user.admin? || correct_user?(@article.user)
  end
end

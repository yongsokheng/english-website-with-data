class CategoriesController < ApplicationController

  def index
    @category_name = t "menus.top30"
    @big_article = Article.select_popular 1, 0
    @small_articles = Article.select_popular(29, @big_article.last.id)
  end

  def show
    @category_name = Category.find(params[:id]).name
    @big_article = Article.find_published_articles 1, 0, params[:id]
    @small_articles = Article.find_similar_articles(1, @big_article.last.id, params[:id])
      .paginate(page: params[:page], per_page: Settings.per_page) if @big_article.present?
  end
end

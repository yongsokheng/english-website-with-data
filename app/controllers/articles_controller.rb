class ArticlesController < ApplicationController
  before_action :update_view_number, only:[:show]

  def show
    @category_id = @article.category.id
    @articles = Article.find_similar_articles 5, @article.id, @category_id
  end

  private
  def update_view_number
    @article = Article.find params[:id]
    @article.update_view_number
  end
end

class StaticPagesController < ApplicationController
  def index
    @categories = Category.all
  end

  def google
  end

  def google2

  end

  def google3
    @article = Article.find 213
  end

  def article_banner
    render layout: false
  end

  def right_banner
    render layout: false
  end

  def device
    auth_id = "YA3SauOMMV9T5dYuyim78w=="
    if auth_id = params[:auth_id]
      register_id = params[:register_id]
      Device.create! registered_id: register_id
    end
    render nothing: true, status: 200
  end
end

class Admin::CategoriesController < ApplicationController
  layout "admin/application"
  before_action :authenticate_user!
  before_action :admin_user, except: [:index]
  before_action :find_category_by_params, only: [:edit, :update, :destroy]

  def index
    @categories = Category.paginate(page: params[:page], per_page: Settings.per_page)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    @category.save
    @categories = Category.all
    flash.now[:notice] = flash_message("created")
  end

  def edit
  end

  def update
    @category.update_attributes category_params
    @categories = Category.all
    flash.now[:notice] = flash_message("updated")
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: flash_message("deleted")
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def find_category_by_params
    @category = Category.find params[:id]
  end
end

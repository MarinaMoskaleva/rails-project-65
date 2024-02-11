class Web::Admin::CategoriesController < Web::Admin::ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.save
      flash[:notice] = I18n.t('flash.notice.category_created')
      redirect_to admin_categories_path
    else
      flash[:error] = I18n.t('flash.error.category_not_created')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find_by(id: params[:id])
  end

  def edit
    @category = Category.find_by(id: params[:id])
  end

  def update
    @category = Category.find_by(id: params[:id])
    if @category.update(category_params)
      flash[:notice] = I18n.t('flash.notice.category_updated')
      redirect_to admin_categories_path
    else
      flash[:error] = I18n.t('flash.error.category_not_updated')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find_by(id: params[:id])
    return if @category.blank?
    
    @category.destroy
    redirect_to admin_categories_path

  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end

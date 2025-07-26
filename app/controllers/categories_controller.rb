# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update show destroy]
  before_action :should_admin, only: %i[new create edit update destroy]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category created successfully'
      redirect_to @category
    else
      render 'new'
    end
  end

  def update
    if @category.update(category_params)
      flash[:success] = 'Category updated successfully'
      redirect_to @category
    else
      flash.now[:alert] = 'Something went wrong please try again later'
      render 'edit'
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = 'Category deleted successfully'
      redirect_to categories_path
    else
      flash.now[:alert] = 'Something went wrong please try again later'
      redirect_to @category
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def should_admin
    return if current_user&.admin?

    flash[:alert] = 'Only admin can create category'
    redirect_to categories_path
  end
end

# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show index]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @articles = Article.includes(:user, :categories, :rich_text_description)
                       .paginate(page: params[:page], per_page: 5)
  end

  def show; end

  def edit; end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = 'Article was created successfully.'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Article was updated successfully.'
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = 'Article was deleted successfully.'
    else
      flash[:alert] = 'Something went wrong, please try again.'
    end

    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    return unless current_user != @article.user && !current_user.admin?

    flash[:alert] = 'You can only edit or delete your own article'
    redirect_to @article
  end
end

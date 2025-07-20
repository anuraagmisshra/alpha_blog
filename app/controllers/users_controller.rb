# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_user, only: %i[update destroy]
  before_action :same_user, only: %i[edit destroy]
  include Recaptcha::Adapters::ViewMethods
  include Recaptcha::Adapters::ControllerMethods

  def new
    @user = User.new
  end

  def index
    @users = User.includes(:articles).paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(user_params)
    if verify_recaptcha(model: @user) && @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to alpha blog #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = "Account update for #{@user.username}"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    return unless @user.destroy

    session[:user_id] = nil if @user == current_user
    flash[:alert] = 'You account deleted successfully'
    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def same_user
    return unless current_user != @user && !current_user.admin?

    flash[:alert] = 'You can only edit or delete your own account'
    redirect_to @user
  end
end

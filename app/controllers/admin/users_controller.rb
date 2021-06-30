class Admin::UsersController < ApplicationController
  # before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice:'<< Successfully created new user >>'
    else
      render :new
    end
  end

  def show; end

  def edit;  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice:'<< Successfully updated the user! >>'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "<< Successfully deleted the user >>"
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  # private
  # def if_not_admin
  #   redirect_to tasks_path, notice: 'Not authorised to access the page' unless current_user.admin?
  # end
end

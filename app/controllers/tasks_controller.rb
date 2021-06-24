class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:name_search].present? || params[:status_search].present?
      if params[:name_search].present? && params[:status_search].present?
        @tasks = Task.where('name LIKE ?', "%#{params[:name_search]}%")
      elsif params[:name_search].present?
        @tasks = Task.where('name LIKE ?', "%#{params[:name_search]}%")
      elsif params[:status_search].present?
        @tasks = Task.where(status: params[:status_search])
      end
    elsif params[:sort_expired]
      @tasks = Task.all.order(expire_on: :desc)
    else
      @tasks = Task.all.order(created_at: :desc)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Taskを作成しました！"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "更新しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "削除しました！"
  end

  private
  def task_params
    params.require(:task).permit(:name, :detail, :id, :expire_on, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

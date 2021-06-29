class TasksController < ApplicationController
  # skip_before_action :login_required, only [:]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks
    if params[:name_search].present? || params[:status_search].present?
      if params[:name_search].present? && params[:status_search].present?
        @tasks = @tasks.by_name(params[:name_search]).by_status(params[:status_search])
      elsif params[:name_search].present?
        @tasks = @tasks.by_name(params[:name_search])
      elsif params[:status_search].present?
        @tasks = @tasks.by_status(params[:status_search])
      end
    elsif params[:sort_expired]
      @tasks = @tasks.order(expire_on: :desc)
    elsif params[:sort_priority]
      @tasks = @tasks.order(priority: :asc)
    else
      @tasks = @tasks.order(created_at: :desc)
    end
    @tasks = @tasks.page(params[:page]).per(5)
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:name, :detail, :id, :expire_on, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

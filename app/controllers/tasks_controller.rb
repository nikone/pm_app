class TasksController < ApplicationController
  after_action :verify_authorized, except: :index
  before_filter :set_task, only: [:show, :update, :destroy]

  def index
    project = Project.find(params[:project_id])
    user_not_authorized unless current_user.added_to_project?(project)

    @boards = project.boards.includes(:active_tasks => :tags)
  end

  def create
    task = Task.new(task_params)
    authorize task
    if task.save
      render json: task, status: 201, location: [task]
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  def show
  end

  def update
    if @task.update(task_params)
      render json: @task, status: 200, location: [@task] 
    else
      render json: { errors: @task.errors }, status: 422
    end
  end

  def destroy
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :board_id, :creator_id, 
      :assignee_id, :completed)
  end

  def set_task
    @task = Task.find(params[:id])
    authorize @task
  end
end


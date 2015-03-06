class TasksController < ApplicationController
  before_filter :set_task, only: [:show, :update, :destroy]
  before_filter :check_permissions!

  def index
    project = Project.find(params[:project_id])
    @boards = project.boards.includes(:tasks => :tags)
  end

  def create
    task = Task.new(task_params, project_id: params[:project_id])
    if task.save
      render json: task, status: 201, location: [task]
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :board_id, :creator_id, :assignee_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def check_permissions!
    action = params[:action].to_sym
    project_id = @task.board.project.id if [:show, :update, :destroy].include?(action)
    project_id = params[:project_id] if [:index, :create].include?(action)

    unless current_user.projects.pluck(:id).include?(project_id.to_i)
      render json: { error: "You dont have permission" }, status: :unauthorized
    end
  end
end


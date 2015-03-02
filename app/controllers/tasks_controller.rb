class TasksController < ApplicationController
  def show
    @task = Task.find(params[:id])
  end

  def create
    task = Task.new(task_params)
    if task.save
      render json: task, status: 201, location: [task]
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :creator_id, :assignee_id)
  end
end

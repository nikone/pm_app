class ProjectsController < ApplicationController
  after_action :verify_authorized
  before_filter :set_project, only: [:show, :update, :destroy]

  def index
    @projects = current_user.projects
    authorize @projects
  end

  def create
    project = Project.new(project_params)
    authorize project
    if project.save
      current_user.projects << project
      render json: project, status: 201, location: [project] 
    else
      render json: { errors: project.errors }, status: 422
    end
  end

  def show
  end

  def update
    if @project.update(project_params)
      render json: @project, status: 200, location: [@project] 
    else
      render json: { errors: @project.errors }, status: 422
    end
  end

  def destroy 
    @project.destroy
    head 204
  end

  private
  def project_params
    params.require(:project).permit(:title, :description)
  end

  def set_project
    @project = Project.find(params[:id])
    authorize @project
  end
end

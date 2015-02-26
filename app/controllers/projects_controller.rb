class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def update
    project = Project.find(params[:id])
    if project.update(project_params)
      render json: project, status: 200, location: [project]
    else
      render json: { errors: project.errors }, status: 422
    end
  end

  def create
    project = Project.new(project_params) 
    if project.save
      render json: project, status: 201, location: [project] 
    else
      render json: { errors: project.errors }, status: 422
    end
  end

  private
  def project_params
    params.require(:project).permit(:title, :description)
  end
end

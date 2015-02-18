class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
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

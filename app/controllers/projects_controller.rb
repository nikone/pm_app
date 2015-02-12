class ProjectsController < ApplicationController
  def index
    respond_with Project.all
  end
end

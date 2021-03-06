class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy complete]

  # GET /projects
  def index
    unless current_user
      redirect_to root_path
    end

    @parts = Part.where(user: current_user)
    .filter { |p| p.remaining_quantity < 0 }.sort_by(&:remaining_quantity)

    @projects = Project.where(user: current_user)
  end

  # GET /projects/1
  def show; end

  # GET /projects/1/edit
  def edit; end

  # POST /projects
  def create
    @project = Project.new(project_params)
    @project.user = current_user

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  def complete
    @project.complete!
    redirect_to projects_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])

    unless current_user and @project.user == current_user
      raise ActionController::RoutingError, 'Not Found'
    end
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name)
  end
end

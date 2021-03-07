class RequirementsController < ApplicationController
  before_action :set_project, only: %i[index create pdate destroy]
  before_action :set_requirement, only: %i[update destroy]

  def index
    respond_to do |format|
      format.json { render json: @project.to_json(include: { requirements: { include: :part } }) }
    end
  end

  def create
    project = Project.find(params[:project_id])

    req_params = requirement_params
    part_params = req_params.delete :part
    part_params['user'] = current_user

    part = Part.find_or_initialize_by(part_params)
    @requirement = Requirement.find_by(project: project, part: part)

    if @requirement
      @requirement.increment(:quantity, req_params[:quantity].to_i)
    else
      @requirement = Requirement.new(req_params)
      @requirement.part = part
      @requirement.project = project
    end

    if part.save && @requirement.save
      redirect_to project, notice: 'Requirement was successfully created.'
    else
      render :new
    end
  end

  def update
    @requirement.update requirement_params
    redirect_to [:edit, @project]
  end

  def destroy
    @requirement.destroy!
    redirect_to [:edit, @project]
  end

  private

  def requirement_params
    params.require(:requirement).permit(:quantity, part: %i[part_type value])
  end


  def set_project
    @project = Project.find(params[:project_id])

    unless current_user and @project.user == current_user
      raise ActionController::RoutingError, 'Not Found'
    end
  end

  def set_requirement
    @requirement = @project.requirements.find(params[:id])
  end
end

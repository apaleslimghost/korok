class RequirementsController < ApplicationController
  def index
    project = Project.find(params[:project_id])

    respond_to do |format|
      format.json { render json: project.to_json(include: { requirements: { include: :part } }) }
    end
  end

  def create
    project = Project.find(params[:project_id])

    req_params = requirement_params
    part_params = req_params.delete :part

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
    project = Project.find(params[:project_id])
    requirement = Requirement.find(params[:id])
    requirement.update requirement_params
    redirect_to [:edit, project]
  end

  def destroy
    project = Project.find(params[:project_id])
    requirement = Requirement.find(params[:id])
    requirement.destroy!
    redirect_to [:edit, project]
  end

  private

  def requirement_params
    params.require(:requirement).permit(:quantity, part: %i[part_type value])
  end
end

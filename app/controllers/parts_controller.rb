class PartsController < ApplicationController
  before_action :set_part, only: %i[update]

  # GET /parts
  def index
    @parts = Part.where(user: current_user).where.not(quantity: 0)
  end

  def add
    @parts = Part.where(user: current_user).sort_by(&:remaining_quantity)
  end

  # POST /parts
  def create
    all_params = part_params
    quantity = all_params.delete(:quantity)
    all_params['user'] = current_user

    @part = Part.find_or_initialize_by(all_params)
    @part.increment(:quantity, quantity.to_i)

    if @part.save
      redirect_to parts_path, notice: 'Part was successfully created.'
    else
      render :index
    end
  end

  # PATCH/PUT /parts/1
  def update
    if @part.update(part_params)
      redirect_to add_parts_path, notice: 'Part was successfully updated.'
    else
      render :add
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_part
    @part = Part.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def part_params
    params.require(:part).permit(:part_type, :value, :quantity)
  end
end

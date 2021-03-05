class PartsController < ApplicationController
  before_action :set_part, only: %i[update]

  # GET /parts
  def index
    @parts = Part.where.not(quantity: 0).order(:value)
  end

  def add
    @parts = Part.all.sort_by(&:remaining_quantity)
  end

  # POST /parts
  def create
    all_params = part_params
    quantity = all_params.delete(:quantity)
    all_params['user'] = current_user

    @part = Part.where(all_params).first_or_initialize
    @part.increment(:quantity, quantity.to_i)

    if @part.save
      redirect_to @part, notice: 'Part was successfully created.'
    else
      render :new
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

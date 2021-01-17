class PartsController < ApplicationController
  before_action :set_part, only: %i[show edit update destroy]

  # GET /parts
  def index
    @parts = Part.where.not(quantity: 0).order(:value)
  end

  # GET /parts/1
  def show; end

  # GET /parts/new
  def new
    @part = Part.new
  end

  # GET /parts/1/edit
  def edit; end

  def add
    @parts = Part.all.sort_by(&:remaining_quantity)
  end

  # POST /parts
  def create
    all_params = part_params
    quantity = all_params.delete(:quantity)
    puts quantity, all_params

    @part = Part.find_or_initialize_by(all_params)
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

  # DELETE /parts/1
  def destroy
    @part.destroy
    redirect_to parts_url, notice: 'Part was successfully destroyed.'
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

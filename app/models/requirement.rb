class Requirement < ApplicationRecord
  belongs_to :part
  belongs_to :project

  def part_type
    part.part_type
  end

  def fulfilled
    quantity <= part.quantity
  end

  def use_parts!
    part.decrement!(:quantity, quantity)
  end
end

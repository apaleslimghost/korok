class Requirement < ApplicationRecord
  belongs_to :part
  belongs_to :project
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

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

class Part < ApplicationRecord
  has_many :requirements
  has_many :projects, through: :requirements

  def remaining_quantity
    quantity - requirements.map(&:quantity).sum
  end
end

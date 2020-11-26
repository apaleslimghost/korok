class Part < ApplicationRecord
  has_many :requirements
  has_many :projects, through: :requirements

  def allocated_quantity(excluding: nil)
    requirements.reject { |req| req == excluding }.map(&:quantity).sum
  end

  def remaining_quantity(excluding: nil)
    quantity - allocated_quantity(excluding: excluding)
  end
end

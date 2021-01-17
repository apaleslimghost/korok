class Part < ApplicationRecord
  has_many :requirements
  has_many :projects, through: :requirements
  validates :part_type, presence: true
  validates :value, presence: true
  validates :quantity, numericality: true

  normalize_attribute :value do |value|
    Unit.new value
  rescue ArgumentError
    value
  end

  def allocated_quantity(excluding: nil)
    requirements.reject { |req| req == excluding }.map(&:quantity).sum
  end

  def remaining_quantity(excluding: nil)
    quantity - allocated_quantity(excluding: excluding)
  end

  # make sure find_or_initialize_by uses normalised value
  def self.find_or_initialize_by(attributes)
    part = Part.new(attributes)
    super(part.attributes.slice('part_type', 'value'))
  end
end

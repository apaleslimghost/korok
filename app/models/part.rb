class Part < ApplicationRecord
  belongs_to :user
  has_many :requirements
  has_many :projects, through: :requirements
  validates :part_type, presence: true
  validates :value, presence: true
  validates :quantity, numericality: true

  normalize_attribute :value, :to_unit_maybe
  normalize_attribute :part_type, :singularize

  def allocated_quantity(excluding: nil)
    requirements.reject { |req| req == excluding }.map(&:quantity).sum
  end

  def remaining_quantity(excluding: nil)
    quantity - allocated_quantity(excluding: excluding)
  end

  def self.find_or_initialize_by(params)
    params[:value] = params[:value].to_unit_maybe
    Part.where(params).first_or_initialize
  end

  def value
    self[:value].to_unit_maybe if self[:value]
  end
end

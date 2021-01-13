class Project < ApplicationRecord
  has_many :requirements
  has_many :parts, through: :requirements
  validates :title, presence: true

  def requirements_by_part_type
    requirements.group_by(&:part_type)
  end

  def ready
    requirements.all?(&:fulfilled)
  end

  def missing
    requirements.reject(&:fulfilled)
  end

  def complete!
    transaction do
      requirements.each(&:use_parts!)
      update!(complete: true)
    end
  end
end

class Project < ApplicationRecord
  has_many :requirements
  has_many :parts, through: :requirements

  def requirements_by_part_type
    requirements.group_by &:part_type
  end
end

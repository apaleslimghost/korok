class Project < ApplicationRecord
  has_many :requirements
  has_many :parts, through: :requirements
end

class User < ApplicationRecord
  has_secure_password
  has_many :parts
  has_many :projects
end

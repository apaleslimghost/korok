class User < ApplicationRecord
  has_secure_password
  has_many :parts
  has_many :projects

  def gravatar
    Gravatar.src email
  end
end

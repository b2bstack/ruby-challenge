class User < ApplicationRecord
  paginates_per 10

  has_secure_password

  validates_presence_of :name, :username, :password, :password_confirmation
  validates_uniqueness_of :username

  validates :password,
            length: { minimum: 4 },
            if: -> { new_record? || !password.nil? }

  has_many :todos, dependent: :destroy
end

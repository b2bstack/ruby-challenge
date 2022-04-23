class User < ApplicationRecord
  has_secure_password

  validates_presence_of :name, :username, :password_digest
  validates_uniqueness_of :username

  validates :password,
            length: { minimum: 4 },
            if: -> { new_record? || !password.nil? }

  has_many :todos, dependent: :destroy
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :username, uniqueness: true
  validates :email, uniqueness: true

  validates :username, uniqueness: { case_sensitive: false }, presence: true, allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :todo_lists, dependent: :destroy
  
  def generate_jwt
    if ENV['RAILS_ENV'] == 'development'
      JWT.encode({ id: self.id,
                  exp: 60.days.from_now.to_i },
                 Rails.application.secrets.secret_key_base)
    else
        JWT.encode({ id: self.id,
                  exp: 60.days.from_now.to_i },
                 Rails.application.secret_key_base)
    end
  end
end

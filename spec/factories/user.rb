FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    username { name.downcase }
    password { SecureRandom.hex(3) }
    password_confirmation { password }
  end
end

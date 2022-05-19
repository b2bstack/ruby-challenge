# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    status { 0 }
  end
end

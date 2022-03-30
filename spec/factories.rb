FactoryBot.define do

  factory :todo_list do
    title { "MyString" }
    items_count { 1 }
    created_at { "2022-03-29 17:56:40" }
    updated_at { "2022-03-29 17:56:40" }
    mode { 1 }
    description { "MyText" }
    user { nil }
  end

  factory :user do
    id { 1 }
    username { "MyString" }
    email { "MyString" }
    password { "MyString" }
  end


end
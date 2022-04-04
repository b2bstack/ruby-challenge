FactoryBot.define do
  factory :item do
    id { 1 }
    todo_list { nil }
    action { "MyString" }
    mode { 1 }
  end


  factory :todo_list do
    id { 1 }
    title { "MyString" }
    items_count { 1 }
    mode { 0 }
    created_at { "2022-03-29 17:56:40" }
    updated_at { "2022-03-29 17:56:40" }
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
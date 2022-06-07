# frozen_string_literal: true

# Seed dummy data for development
quantity = 100

todo_items = []

quantity.times do
  todo_items.push({
    is_archived: ::Faker::Boolean.boolean,
    is_readed: ::Faker::Boolean.boolean,
    is_executed: ::Faker::Boolean.boolean,
    weight: ::Faker::Number.within(range: 1..quantity),
    title: ::Faker::Hobby.activity,
    description: ::Faker::Lorem.question(word_count: 5),
  })
end

# ap todo_items

TodoItem.insert_all!(todo_items)

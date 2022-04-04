# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


def initial_create 
    if User.all.count == 0
        User.create(email: "mail@mail.com", password: "password", username: "username")

        (1..20).each do |i|
            Todo.create(title: "Todo #{i}", user_id: 1, action: "If u request it in a show ,ethod it will be changed of pending to read")
        end
    end
end
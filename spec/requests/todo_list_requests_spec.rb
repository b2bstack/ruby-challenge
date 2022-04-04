require 'rails_helper'

RSpec.describe "Todo Lists", type: :request do


    before(:all) do
        @user = create(:user, email: 'mails@mails.com', username: 'user1', password: 'password', id: 1, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
        @user2 = create(:user, email: 'mails@mail.com', username: 'user2', password: 'password', id: 2, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    end

    describe "GET /" do

        it "returns error with null token" do
            get_with_token '/api/todo_lists', nil, nil, nil
            expect(response).to have_http_status(401)

        end

        it "return a paginated and serialized list of todo lists on index" do
            get_with_token "/api/todo_lists"
            
            expect(response.body).to eq({data: []}.to_json)
        end

        it "not expose todo list of another user" do
            todo_list = create(:todo_list, title: 'some title', description: 'some description', user_id: 1)
            todo_list_another_user = create(:todo_list, title: 'some title 2', description: 'some description', id: 3, user_id: 2)
            get_with_token "/api/todo_lists"
            expect(response.body).to eq({data: [{id: todo_list.id.to_s, type: 'todo-lists', attributes: {title: todo_list.title, description: todo_list.description, mode: "pending", "created-at": todo_list.created_at, "updated-at": todo_list.updated_at, "items-count": 1  }}]}.to_json)
        end

        it "can be accessed by the user who created it" do
            todo_list = create(:todo_list, title: 'some title', description: 'some description', user_id: 1)
            get_with_token "/api/todo_lists/#{todo_list.id}"
            expect(response.body).to eq({data: {id: todo_list.id.to_s, type: 'todo-lists', attributes: {title: todo_list.title, description: todo_list.description, mode: "pending", "created-at": todo_list.created_at, "updated-at": todo_list.updated_at, "items-count": 1  }}}.to_json)
        end

        it "cannot be accessed by another user" do
            todo_list = create(:todo_list, title: 'some title', description: 'some description', user_id: 2)
            get_with_token "/api/todo_lists/#{todo_list.id}"
            expect(response).to have_http_status(404)
        end

        it "need a user to be logged in to show todo_list" do
            todo_list = create(:todo_list, title: 'some title', description: 'some description', user_id: 1)
            get "/api/todo_lists/#{todo_list.id}"
            expect(response).to have_http_status(401)
        end

    end
    describe "POST /" do

        let (:todo_list_params) do
            {
                todo_list: {
                    title: "some title",
                    description: "some description",
                    user_id: 1,
                    mode: "pending"
                }
            }
        end

        it "creates a todo list" do
            post_with_token "/api/todo_lists", todo_list_params
            expect(response.body).to eq({data: {id: TodoList.last.id.to_s, type: "todo-lists", attributes: { title: TodoList.last.title, description: TodoList.last.description, mode: "pending", "created-at": TodoList.last.created_at, "updated-at": TodoList.last.updated_at, "items-count": 0  } }}.to_json)
        end

        it "need a user to be logged in to create a todo list" do
            post "/api/todo_lists", params: todo_list_params
            expect(response).to have_http_status(401)
        end

        it "returns error with title already used" do
            first_create = create(:todo_list, title: 'some title', description: 'some description', user_id: 1)
            post_with_token "/api/todo_lists", todo_list_params
            expect(response).to have_http_status(422)
        end

        it "returns error with null title" do
            todo_list_params_2 = todo_list_params
            todo_list_params_2[:todo_list][:title] = nil
            post_with_token "/api/todo_lists", todo_list_params_2
            expect(response).to have_http_status(422)
        end

        it "return sucess with null description" do
            todo_list_params_2 = todo_list_params
            todo_list_params_2[:todo_list][:description] = nil
            post_with_token "/api/todo_lists", todo_list_params
            expect(response.body).to eq({data: {id: TodoList.last.id.to_s, type: "todo-lists", attributes: { title: TodoList.last.title, description: TodoList.last.description, mode: "pending", "created-at": TodoList.last.created_at, "updated-at": TodoList.last.updated_at, "items-count": 0  } }}.to_json)
        end

        it "create on current user even if user_id is null " do
            todo_list_params_2 = todo_list_params
            todo_list_params_2[:todo_list][:user_id] = nil
            post_with_token "/api/todo_lists", todo_list_params_2
            TodoList.find(TodoList.last.id).user_id.should eq(@user.id)
        end
        
        it "create on current user even if user_id is not null but not the current user" do
            todo_list_params_2 = todo_list_params
            todo_list_params_2[:todo_list][:user_id] = 2
            post_with_token "/api/todo_lists", todo_list_params_2
            TodoList.find(TodoList.last.id).user_id.should eq(@user.id)
        end

    end

end
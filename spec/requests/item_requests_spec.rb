require 'rails_helper'

RSpec.describe "Items", type: :request do
    before(:all) do
        @user = create(:user, email: 'mails@mails.com', password: 'password', username: 'user1', id: 1, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
        @user2 = create(:user, email: 'mails@mail.com', username: 'user2', password: 'password', id: 2, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
        @todo_list = create(:todo_list, id: 1,title: 'some title', description: 'some description', user_id: 1)
        @todo_list = create(:todo_list, id: 2,title: 'some titled thing', description: 'some description', user_id: 2)
        @item = create(:item, todo_list_id: 1, name: "item 1", action: 'some action', id: 1, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    end
    

    describe "GET /items" do

        let (:todo_list_id) do
            {
                todo_list_id: 1
            }
        end

        let (:todo_list_id_2) do
            {
                todo_list_id: 2
            }
        end


        it "returns http error without token" do
            get "/api/items"
            expect(response).to have_http_status(401)
        end

        it "return 404 if not especify a list of items on index" do
            get_with_token "/api/items"
            expect(response).to have_http_status(404)
        end

        it "can be accessed by the user who created it" do
            get_with_token "/api/items", todo_list_id
            expect(response).to have_http_status(200)
        end

        it "can't be accessed by another user" do
            todo_list_2 = create(:todo_list, id: 3,title: 'some titled', description: 'some description', user_id: 2)
            get_with_token "/api/items", todo_list_2
            expect(response).to have_http_status(404)
        end

        it "return a paginated and serialized list of items on index" do
            get_with_token "/api/items", todo_list_id
            expect(response.body).to eq({data: [{id: @item.id.to_s, type: 'items', attributes: {name: "item 1", action: @item.action, mode: @item.mode, "created-at": @item.created_at, "updated-at": @item.updated_at, "todo-list-id": @item.todo_list_id}}]}.to_json)
        end

        it "return error if a todo list is not found" do
            begin 
                get_with_token "/api/items", {todo_list_id: 3}

            rescue ActiveRecord::RecordNotFound => e
                expect(e).to be_a(ActiveRecord::RecordNotFound)
            end
        end
        
    end

    describe "POST /items" do

        let (:item_params) do
            {
                item:
                {
                    todo_list_id: 1,
                    name: "item 2",
                    action: 'some action',
                    mode: "pending",
                }
            }
        end

        it "returns http error without token" do
            post "/api/items"
            expect(response).to have_http_status(401)
        end

        it "returns http error if params are null" do
            begin
                post_with_token "/api/items", {item: {}}
            rescue ActionController::ParameterMissing => e
                expect(e).to be_a(ActionController::ParameterMissing)
            end
        end

        it "returns http error if params are not valid" do
            begin 
                post_with_token "/api/items", {item: {todo_list_id: "a", name: "item 2", action: 'some action', mode: "a"}}
            rescue ArgumentError => e
                expect(e).to be_a(ArgumentError)
            end
        end

        it "returns http error if todo_list is not property of current user" do
            ActiveRecord::Base.connection.tables.each do |t|
                ActiveRecord::Base.connection.reset_pk_sequence!(t)
            end
            post_with_token "/api/items", {item: {todo_list_id: 2, name: "item 2", action: 'some action'}}
            expect(response).to have_http_status(422)
        end

        it "returns http error if todo_list is not found" do
            begin
                post_with_token "/api/items", {item: {todo_list_id: 3, name: "item 2", action: 'some action'}}
            rescue ActiveRecord::RecordNotFound => e
                expect(e).to be_a(ActiveRecord::RecordNotFound)
            end
        end

        it "returns http error if item is not created" do
            begin
                post_with_token "/api/items", {item: {todo_list_id: 1, name: "item 2", action: 'some action'}}
            rescue ActiveRecord::RecordInvalid => e
                expect(e).to be_a(ActiveRecord::RecordInvalid)
            end
        end

        it "returns http success if item is created" do
            post_with_token "/api/items", item_params
            expect(response.body).to eq({data: {id: Item.last.id.to_s, type: 'items', attributes: {name: "item 2", action: "some action", mode: "pending", "created-at": Item.last.created_at, "updated-at": Item.last.updated_at, "todo-list-id": Item.last.todo_list_id}}}.to_json)
        end

        it "return error if try to save without name" do
            post_with_token "/api/items", {item: {todo_list_id: 1, action: 'some action'}}
            expect(response).to have_http_status(422)
        end

    end

end
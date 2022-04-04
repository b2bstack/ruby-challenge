require 'rails_helper'

RSpec.describe TodoList, type: :model do
  before(:all) do
    @user1 = create(:user, email: 'mail@mail.com', password: 'password', username: 'user1', id: 1, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    @todo_list = create(:todo_list, title: 'some title', description: 'some description', user_id: 1)
  end
  
  it "is valid with valid attributes" do
    expect(@todo_list).to be_valid
  end

  it "is not valid without a title" do
    todo_list = build(:todo_list, title: nil, description: 'some description', user_id: 1, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    expect(todo_list).to_not be_valid 
  end

  it "is valid without a description" do
    todo_list = build(:todo_list, title: 'some titles', description: nil, user_id: 1, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    expect(todo_list).to be_valid
  end

  it "is not valid without a user_id" do
    todo_list = build(:todo_list, title: 'some titles', description: 'some description', user_id: nil, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    expect(todo_list).to_not be_valid
  end
 
end

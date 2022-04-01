require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:all) do
    @user1 = create(:user, email: 'mail@mail.com', password: 'password', username: 'user1', id: 1, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    @todo_list = create(:todo_list, title: 'some title', description: 'some description', user_id: 1)
    @item = create(:item, todo_list_id: 1, name: 'item teste',action: 'some action', mode: 1, id: 1, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
  end

  it "is valid with valid attributes" do
    expect(@item).to be_valid
  end

  it "is not valid without a todo_list_id" do
    item_2 = build(:item, todo_list_id: nil,  name: 'item teste', action: 'some action', mode: 1, id: 1, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    expect(item_2).to_not be_valid
  end

  it "is not valid without a action" do
    item_2 = build(:item, todo_list_id: 1,  name: 'item teste', action: nil, mode: 1, id: 1, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    expect(item_2).to_not be_valid
  end

  it "is valid without a mode" do
    item_2 = build(:item, todo_list_id: 1,  name: 'item teste', action: 'some action', mode: nil, id: 1, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    expect(item_2).to be_valid
  end

  it "is not valid without a name" do
    item_2 = build(:item, todo_list_id: 1,  name: nil, action: 'some action', mode: 1, id: 1, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    expect(item_2).to_not be_valid
  end
  
end

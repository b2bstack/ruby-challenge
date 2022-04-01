require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user1 = create(:user, email: 'mail@mail.com', password: 'password', username: 'user1', id: 1, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
  end
  
  it "is valid with valid attributes" do
    expect(@user1).to be_valid
  end
  
  it "has a unique username" do
    user2 = build(:user, email: "bobs@gmail.com", username: "user1", password: "12345678", id: 2, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    expect(user2).to_not be_valid
  end
  
  it "has a unique email" do
    user2 = build(:user, email: "mail@mail.com", username: "bob", password: "12345678", id: 2, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    expect(user2).to_not be_valid
  end
  
  it "is not valid without a password" do 
    user2 = build(:user, email: "bobs@gmail.com", username: "bob", password: nil, id: 2, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    expect(user2).to_not be_valid
  end
  
  it "is not valid without a username" do 
    user2 = build(:user, email: "bobs@gmail.com", username: nil, password: "12345678", id: 2, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    expect(user2).to_not be_valid
  end
  
  it "is not valid without an email" do
    user2 = build(:user, email: nil, username: "bob", password: "12345678", id: 2, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    expect(user2).to_not be_valid
  end

end

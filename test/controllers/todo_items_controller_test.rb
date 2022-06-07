# frozen_string_literal: true

require "test_helper"

class TodoItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todo_item = todo_items(:one)
  end

  test "should get index" do
    get todo_items_url, as: :json
    assert_response :success
  end

  test "should create todo_item" do
    assert_difference("TodoItem.count") do
      post todo_items_url, params: { todo_item: { description: @todo_item.description, is_archived: @todo_item.is_archived, is_executed: @todo_item.is_executed, is_readed: @todo_item.is_readed, title: @todo_item.title, weight: @todo_item.weight } }, as: :json
    end

    assert_response :created
  end

  test "should show todo_item" do
    get todo_item_url(@todo_item), as: :json
    assert_response :success
  end

  test "should update todo_item" do
    patch todo_item_url(@todo_item), params: { todo_item: { description: @todo_item.description, is_archived: @todo_item.is_archived, is_executed: @todo_item.is_executed, is_readed: @todo_item.is_readed, title: @todo_item.title, weight: @todo_item.weight } }, as: :json
    assert_response :success
  end

  test "should destroy todo_item" do
    assert_difference("TodoItem.count", -1) do
      delete todo_item_url(@todo_item), as: :json
    end

    assert_response :no_content
  end
end

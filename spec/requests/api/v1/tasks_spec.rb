# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/tasks', type: :request do
  let(:valid_attributes) do
    attributes_for(:task)
  end

  let(:invalid_attributes) do
    attributes_for(:task, title: nil)
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Task.create! valid_attributes
      get api_v1_tasks_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Task' do
        expect do
          post api_v1_tasks_url,
               params: { task: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Task, :count).by(1)
      end

      it 'renders a JSON response with the new task' do
        post api_v1_tasks_url,
             params: { task: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Task' do
        expect do
          post api_v1_tasks_url,
               params: { task: invalid_attributes }, as: :json
        end.to change(Task, :count).by(0)
      end

      it 'renders a JSON response with errors for the new task' do
        post api_v1_tasks_url,
             params: { task: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested task' do
      task = Task.create! valid_attributes
      expect do
        delete api_v1_task_url(task), headers: valid_headers, as: :json
      end.to change(Task, :count).by(-1)
    end
  end

  describe 'PATCH /status' do
    let(:task) { Task.create! valid_attributes }

    before do
      patch status_api_v1_task_url(task), params: task_params, headers: valid_headers, as: :json
    end

    context 'with valid status params' do
      let(:task_params) { { task: { status: 'executed' } } }

      it 'update the requested task status' do
        expect(response).to have_http_status(:ok)
        expect(json[:data][:attributes][:status]).to eq('executed')
      end
    end

    context 'with invalid status params' do
      let(:task_params) { { task: { status: 'invalid_status' } } }

      it 'returns status error' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json[:errors][:message]).to eq("'invalid_status' is not a valid status")
      end
    end

    context 'when title is sent' do
      let(:task_params) { { task: { title: 'some title' } } }

      it 'it is not updated' do
        expect(response).to have_http_status(:ok)
        expect(task.title).to_not eq('some title')
      end
    end
  end
end

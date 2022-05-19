# frozen_string_literal: true

module Api
  module V1
    class TasksController < BaseController
      before_action :load_task, only: %i[destroy status]

      def index
        @tasks = fetch_all
        render json: serialized_data(@tasks), status: :ok
      end

      def create
        @task = Task.new(task_params)

        if @task.save
          render json: serialized_data(@task), status: :created
        else
          render_failure(@task.errors)
        end
      end

      def destroy
        @task.destroy
        head :no_content
      end

      def status
        if @task.update(task_params.extract!(:status))
          render json: serialized_data(@task), status: :ok
        else
          render_failure(@task.errors)
        end
      rescue StandardError => e
        render_failure(e.message)
      end

      private

      def load_task
        @task = Task.find_by(id: params[:id])
      end

      def task_params
        params.require(:task).permit(:title, :status)
      end

      def fetch_all
        result = Task.order(created_at: :desc)
        result = result.where(status: params[:status]) if params[:status].present?
        result
      end
    end
  end
end

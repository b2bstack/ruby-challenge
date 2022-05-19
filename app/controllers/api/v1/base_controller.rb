# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      QTT_BY_PAGE = 12

      protected

      def serialized_data(resource)
        resource_name = resource.respond_to?(:length) ? resource.class.to_s.split('::').first : resource.class.to_s
        serializer_class = "#{resource_name}Serializer"

        serializer_class.constantize.new(resource).serializable_hash.to_json
      end

      def render_failure(errors, status: :unprocessable_entity)
        errors = { message: errors } if errors.is_a? String

        render json: { errors: }, status:
      end
    end
  end
end

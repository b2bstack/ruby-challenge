# frozen_string_literal: true

class TaskSerializer
  include JSONAPI::Serializer
  attributes :title, :status
end

# frozen_string_literal: true

module RequestHelper
  def json
    @json ||= JSON.parse(response.body, symbolize_names: true)
  end
end

RSpec.configure do |config|
  config.include RequestHelper, type: :request
end

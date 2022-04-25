Apipie.configure do |config|
  config.app_name                = "RubyChallenge"
  config.api_base_url            = "/api"
  config.doc_base_url            = "api/doc"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end

class NumericParam < Apipie::Validator::BaseValidator
  def initialize(param_description, argument)
    super(param_description)
    @type = argument
  end

  def validate(value)
    value.to_i.to_s == value
  end

  def self.build(param_description, argument, options, block)
    if argument == NumericParam
      self.new(param_description, argument)
    end
  end

  def description
    "Must be #{@type}."
  end
end

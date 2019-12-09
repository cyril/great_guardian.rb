# frozen_string_literal: true

module GreatGuardian
  # Collection of expected values.
  module ExpectedValue
  end
end

Dir[File.join File.dirname(__FILE__), 'expected_value', '*.rb'].each do |fname|
  require_relative fname
end

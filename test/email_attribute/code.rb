# frozen_string_literal: true

begin
  require_relative '../../lib/great_guardian'
rescue ::LoadError
  require '../../lib/great_guardian'
end

class EmailAttribute < GreatGuardian::Attribute::Base
  def self.default_constraints
    {
      pattern: /\A[^@]+@[^@]+$\z/i
    }
  end

  def self.expected_value_type
    ::GreatGuardian::ExpectedValue::String
  end
end

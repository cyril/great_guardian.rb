# frozen_string_literal: true

module GreatGuardian
  module ExpectedValue
    class Base
      def self.types
        raise ::NotImplementedError
      end

      def valid_type?(actual_value)
        self.class.types.any? { |type| actual_value.is_a?(type) }
      end

      def type
        self.class
            .name
            .split("::")
            .fetch(-1)
            .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
            .gsub(/([a-z\d])([A-Z])/,'\1_\2')
            .tr("-", "_")
            .downcase
            .to_sym
      end
    end
  end
end

# require_relative ::File.join('..', 'expected_value')

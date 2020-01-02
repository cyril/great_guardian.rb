require_relative 'base'

module GreatGuardian
  module ExpectedValue
    class Boolean < Base
      def first_matched_error_against(actual_value, is_native: true)
        actual_value = emulate(actual_value) unless is_native

        return :type unless valid_type?(actual_value)
      end

      def self.types
        [::FalseClass, ::TrueClass]
      end

      def emulate(value)
        return true   if value.eql?('true')
        return false  if value.eql?('false')

        value
      end
    end
  end
end

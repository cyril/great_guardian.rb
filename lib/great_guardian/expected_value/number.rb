# frozen_string_literal: true

require_relative 'base'

module GreatGuardian
  module ExpectedValue
    class Number < Base
      attr_reader :min, :max

      def initialize(min: nil, max: nil)
        raise ::ArgumentError, min.inspect if !min.nil? && !min.is_a?(::Numeric)
        raise ::ArgumentError, max.inspect if !max.nil? && !max.is_a?(::Numeric)

        if !min.nil? && !max.nil? && (min > max)
          raise ::ArgumentError, min.inspect, max.inspect
        end

        @min = min
        @max = max
      end

      def first_matched_error_against(actual_value, is_native: true)
        actual_value = emulate(actual_value) unless is_native

        return :type  unless valid_type?(actual_value)
        return :min   if !min.nil? && actual_value < min
        return :max   if !max.nil? && actual_value > max
      end

      def self.types
        [::Numeric]
      end

      def emulate(value)
        if value.match?(/\A-?([0-9]+.)?[0-9]+\z/)
          return value.include?('.') ? value.to_f : value.to_i
        end

        value
      end
    end
  end
end

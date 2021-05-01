# frozen_string_literal: true

require_relative "base"

module GreatGuardian
  module ExpectedValue
    class Array < Base
      attr_reader :minlen, :maxlen

      def self.types
        [::Array]
      end

      def initialize(minlen: nil, maxlen: nil)
        raise ::ArgumentError, minlen.inspect if !minlen.nil? && !minlen.is_a?(::Integer)
        raise ::ArgumentError, maxlen.inspect if !maxlen.nil? && !maxlen.is_a?(::Integer)

        if !minlen.nil? && !maxlen.nil? && (minlen > maxlen)
          raise ::ArgumentError, minlen.inspect, maxlen.inspect
        end

        super()

        @minlen = minlen
        @maxlen = maxlen
      end

      def first_matched_error_against(actual_value, is_native: true)
        actual_value = emulate(actual_value) unless is_native

        return :type    unless valid_type?(actual_value)
        return :minlen  if !minlen.nil? && actual_value.length < minlen
        return :maxlen  if !maxlen.nil? && actual_value.length > maxlen
      end

      def emulate(value)
        if value.to_s.start_with?("[") && value.to_s.end_with?("]")
          return value.to_s.split(",").map(&:strip)
        end

        value
      end
    end
  end
end

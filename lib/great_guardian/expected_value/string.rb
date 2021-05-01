# frozen_string_literal: true

require_relative "base"

module GreatGuardian
  module ExpectedValue
    class String < Base
      attr_reader :minlen, :maxlen, :pattern

      def initialize(minlen: nil, maxlen: nil, pattern: nil)
        raise ::ArgumentError, minlen.inspect if !minlen.nil? && !minlen.is_a?(::Integer)
        raise ::ArgumentError, maxlen.inspect if !maxlen.nil? && !maxlen.is_a?(::Integer)

        if !minlen.nil? && !maxlen.nil? && (minlen > maxlen)
          raise ::ArgumentError, minlen.inspect, maxlen.inspect
        end

        raise ::ArgumentError, pattern.inspect if !pattern.nil? && !pattern.is_a?(::Regexp)

        super

        @minlen   = minlen
        @maxlen   = maxlen
        @pattern  = pattern
      end

      def first_matched_error_against(actual_value, is_native: true)
        actual_value = emulate(actual_value) unless is_native

        return :type    unless valid_type?(actual_value)
        return :minlen  if !minlen.nil? && actual_value.length < minlen
        return :maxlen  if !maxlen.nil? && actual_value.length > maxlen
        return :pattern if !pattern.nil? && !actual_value.match?(pattern)
      end

      def self.types
        [::String]
      end

      def emulate(value)
        value.to_s
      end
    end
  end
end

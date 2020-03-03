# frozen_string_literal: true

module GreatGuardian
  # Verdict of Great Guardian.
  class Verdict
    attr_reader :value, :error_message, :medium

    def initialize(attribute_name, value, error_message, medium)
      raise ::ArgumentError, medium.inspect unless %i[body header querystring].include?(medium)

      @attribute_name = attribute_name
      @value          = value
      @error_message  = error_message
      @medium         = medium
    end

    def valid?
      error_message.nil?
    end

    def invalid?
      !valid?
    end

    def to_s
      @attribute_name
    end
  end
end

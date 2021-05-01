# frozen_string_literal: true

module GreatGuardian
  module Attribute
    class Base
      attr_reader :custom_constraints, :default_value, :medium

      def self.default_constraints
        {}
      end

      def self.default_value; end

      def self.first_matched_error_on_complex_validation_logic_against(_actual_value); end

      def self.possible_values; end

      def initialize(default_value: nil, medium: :body, required: true, **custom_constraints)
        raise ::ArgumentError, required.inspect unless [false, true].include?(required)
        raise ::ArgumentError, medium.inspect    unless %i[body header querystring].include?(medium)

        @custom_constraints = custom_constraints
        @default_value      = default_value
        @medium             = medium
        @required           = required
      end

      def call(actual_value)
        actual_value  = actual_value_or_default_value(actual_value)
        error_message = compute_error_message(actual_value)

        Verdict.new(to_s, actual_value, error_message, medium)
      end

      def constraints
        self.class.default_constraints.merge(**custom_constraints)
      end

      def expected_value
        self.class.expected_value_type.new(**constraints)
      end

      def required?
        @required
      end

      def to_s
        self.class
            .name
            .split("::")
            .fetch(-1)
            .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
            .gsub(/([a-z\d])([A-Z])/,'\1_\2')
            .tr("-", "_")
            .downcase
      end

      def to_sym
        to_s.to_sym
      end

      def body?
        medium.equal?(:body)
      end

      def header_or_querystring?
        !body?
      end

      private

      def actual_value_or_default_value(actual_value)
        return actual_value unless not_required_and_nil_or_empty?(actual_value)

        return default_value            unless default_value.nil?
        return self.class.default_value unless self.class.default_value.nil?

        actual_value
      end

      def compute_error_message(actual_value)
        return if not_required_and_nil_or_empty?(actual_value)

        if required_but_nil?(actual_value)
          return i18n_attribute_error(:required, name: i18n_attribute_name)
        end

        first_error = expected_value.first_matched_error_against(actual_value, is_native: body?)

        if first_error.nil?
          unless self.class.possible_values.nil?
            actual_value_is_included_in_possible_values = if self.class.expected_value_type.equal?(::GreatGuardian::ExpectedValue::Array)
                                                            actual_value.all? { |item| self.class.possible_values.include?(item) }
                                                          else
                                                            self.class.possible_values.include?(actual_value)
                                                          end

            unless actual_value_is_included_in_possible_values
              return i18n_attribute_error(:possible_values,
                name:     i18n_attribute_name,
                expected: self.class.possible_values.map(&:inspect).sort.join(", ")
              )
            end
          end

          error_on_complex_validation_logic = self.class.first_matched_error_on_complex_validation_logic_against(actual_value)

          unless error_on_complex_validation_logic.nil?
            return i18n_attribute_error(error_on_complex_validation_logic)
          end
        end

        return if first_error.nil?

        expected = expected_value.public_send(first_error)

        if first_error.equal?(:type)
          expected = i18n_expected_value_type(expected_value.type)
        end

        i18n_attribute_error(first_error,
          name:     i18n_attribute_name,
          expected: expected
        )
      end

      def not_required_and_nil_or_empty?(actual_value)
        return false if required?

        return true if actual_value.nil?        && body?
        return true if actual_value.to_s.empty? && header_or_querystring?

        false
      end

      def required_but_nil?(actual_value)
        actual_value.nil? && required?
      end

      def i18n_attribute_root_key
        "attribute.#{self.to_sym}"
      end

      def i18n_attribute_name
        [
          "#{i18n_attribute_root_key}.name"
        ]
      end

      def i18n_expected_value_type(expected_value)
        [
          "expected_value.#{expected_value}.type"
        ]
      end

      def i18n_attribute_error(error, name: nil, expected: nil)
        [
          "#{i18n_attribute_root_key}.errors.#{error}",
          {
            name:     name,
            expected: expected
          }
        ]
      end
    end
  end
end

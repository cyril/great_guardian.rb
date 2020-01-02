# frozen_string_literal: true

require 'simplecov'

SimpleCov.command_name 'Brutal test suite'
SimpleCov.start

begin
  require_relative '../../lib/great_guardian'
rescue ::LoadError
  require '../../lib/great_guardian'
end

class EmailAttribute < GreatGuardian::Attribute::Base
  def self.expected_value_type
    ::GreatGuardian::ExpectedValue::String
  end

  def self.default_constraints
    {
      pattern: /\A[^@]+@[^@]+$\z/i
    }
  end
end

# ------------------------------------------------------------------------------

front_object = EmailAttribute

# ------------------------------------------------------------------------------

actual = front_object.new(required: true).call(nil)

raise unless actual.valid? == false
raise unless actual.invalid? == true
raise unless actual.to_s == "email_attribute"
raise unless actual.value == nil
raise unless actual.error_message == ["attribute.email_attribute.errors.required", {:name=>["attribute.email_attribute.name"], :expected=>nil}]
raise unless actual.medium == :body

# ------------------------------------------------------------------------------

actual = front_object.new(required: false).call(nil)

raise unless actual.valid? == true
raise unless actual.invalid? == false
raise unless actual.to_s == "email_attribute"
raise unless actual.value == nil
raise unless actual.error_message == nil
raise unless actual.medium == :body

# ------------------------------------------------------------------------------

actual = front_object.new(required: true).call(4)

raise unless actual.valid? == false
raise unless actual.invalid? == true
raise unless actual.to_s == "email_attribute"
raise unless actual.value == 4
raise unless actual.error_message == ["attribute.email_attribute.errors.type", {:name=>["attribute.email_attribute.name"], :expected=>["expected_value.string.type"]}]
raise unless actual.medium == :body

# ------------------------------------------------------------------------------

actual = front_object.new(required: false).call(4)

raise unless actual.valid? == false
raise unless actual.invalid? == true
raise unless actual.to_s == "email_attribute"
raise unless actual.value == 4
raise unless actual.error_message == ["attribute.email_attribute.errors.type", {:name=>["attribute.email_attribute.name"], :expected=>["expected_value.string.type"]}]
raise unless actual.medium == :body

# ------------------------------------------------------------------------------

actual = front_object.new(required: true).call('boom')

raise unless actual.valid? == false
raise unless actual.invalid? == true
raise unless actual.to_s == "email_attribute"
raise unless actual.value == "boom"
raise unless actual.error_message == ["attribute.email_attribute.errors.pattern", {:name=>["attribute.email_attribute.name"], :expected=>/\A[^@]+@[^@]+$\z/i}]
raise unless actual.medium == :body

# ------------------------------------------------------------------------------

actual = front_object.new(required: false).call('boom')

raise unless actual.valid? == false
raise unless actual.invalid? == true
raise unless actual.to_s == "email_attribute"
raise unless actual.value == "boom"
raise unless actual.error_message == ["attribute.email_attribute.errors.pattern", {:name=>["attribute.email_attribute.name"], :expected=>/\A[^@]+@[^@]+$\z/i}]
raise unless actual.medium == :body

# ------------------------------------------------------------------------------

actual = front_object.new(required: true).call('bob@gmail.com')

raise unless actual.valid? == true
raise unless actual.invalid? == false
raise unless actual.to_s == "email_attribute"
raise unless actual.value == "bob@gmail.com"
raise unless actual.error_message == nil
raise unless actual.medium == :body

# ------------------------------------------------------------------------------

actual = front_object.new(required: false).call('bob@gmail.com')

raise unless actual.valid? == true
raise unless actual.invalid? == false
raise unless actual.to_s == "email_attribute"
raise unless actual.value == "bob@gmail.com"
raise unless actual.error_message == nil
raise unless actual.medium == :body

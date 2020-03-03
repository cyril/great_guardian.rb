# frozen_string_literal: true

require 'simplecov'

SimpleCov.command_name 'Brutal test suite'
SimpleCov.start

begin
  require_relative 'code'
rescue ::LoadError
  require './code'
end

# ------------------------------------------------------------------------------

actual = begin
  EmailAttribute.new(required: true).call(nil)
end

raise if actual.valid? != false
raise if actual.invalid? != true
raise if actual.to_s != "email_attribute"
raise if actual.value != nil
raise if actual.error_message != ["attribute.email_attribute.errors.required", {:name=>["attribute.email_attribute.name"], :expected=>nil}]
raise if actual.medium != :body

# ------------------------------------------------------------------------------

actual = begin
  EmailAttribute.new(required: false).call(nil)
end

raise if actual.valid? != true
raise if actual.invalid? != false
raise if actual.to_s != "email_attribute"
raise if actual.value != nil
raise if actual.error_message != nil
raise if actual.medium != :body

# ------------------------------------------------------------------------------

actual = begin
  EmailAttribute.new(required: true).call(4)
end

raise if actual.valid? != false
raise if actual.invalid? != true
raise if actual.to_s != "email_attribute"
raise if actual.value != 4
raise if actual.error_message != ["attribute.email_attribute.errors.type", {:name=>["attribute.email_attribute.name"], :expected=>["expected_value.string.type"]}]
raise if actual.medium != :body

# ------------------------------------------------------------------------------

actual = begin
  EmailAttribute.new(required: false).call(4)
end

raise if actual.valid? != false
raise if actual.invalid? != true
raise if actual.to_s != "email_attribute"
raise if actual.value != 4
raise if actual.error_message != ["attribute.email_attribute.errors.type", {:name=>["attribute.email_attribute.name"], :expected=>["expected_value.string.type"]}]
raise if actual.medium != :body

# ------------------------------------------------------------------------------

actual = begin
  EmailAttribute.new(required: true).call('boom')
end

raise if actual.valid? != false
raise if actual.invalid? != true
raise if actual.to_s != "email_attribute"
raise if actual.value != "boom"
raise if actual.error_message != ["attribute.email_attribute.errors.pattern", {:name=>["attribute.email_attribute.name"], :expected=>/\A[^@]+@[^@]+$\z/i}]
raise if actual.medium != :body

# ------------------------------------------------------------------------------

actual = begin
  EmailAttribute.new(required: false).call('boom')
end

raise if actual.valid? != false
raise if actual.invalid? != true
raise if actual.to_s != "email_attribute"
raise if actual.value != "boom"
raise if actual.error_message != ["attribute.email_attribute.errors.pattern", {:name=>["attribute.email_attribute.name"], :expected=>/\A[^@]+@[^@]+$\z/i}]
raise if actual.medium != :body

# ------------------------------------------------------------------------------

actual = begin
  EmailAttribute.new(required: true).call('bob@gmail.com')
end

raise if actual.valid? != true
raise if actual.invalid? != false
raise if actual.to_s != "email_attribute"
raise if actual.value != "bob@gmail.com"
raise if actual.error_message != nil
raise if actual.medium != :body

# ------------------------------------------------------------------------------

actual = begin
  EmailAttribute.new(required: false).call('bob@gmail.com')
end

raise if actual.valid? != true
raise if actual.invalid? != false
raise if actual.to_s != "email_attribute"
raise if actual.value != "bob@gmail.com"
raise if actual.error_message != nil
raise if actual.medium != :body

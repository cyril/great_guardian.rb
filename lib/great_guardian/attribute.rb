# frozen_string_literal: true

module GreatGuardian
  # Collection of attributes.
  module Attribute
  end
end

Dir[File.join File.dirname(__FILE__), 'attribute', '*.rb'].each do |fname|
  require_relative fname
end

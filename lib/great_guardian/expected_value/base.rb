module GreatGuardian
  module ExpectedValue
    class Base
      def initialize(**)
      end

      def valid_type?(actual_value)
        self.class.types.any? { |type| actual_value.is_a?(type) }
      end

      def type
        self.class.name.split('::').fetch(-1).underscore.to_sym
      end

      def self.types
        raise ::NotImplementedError
      end
    end
  end
end

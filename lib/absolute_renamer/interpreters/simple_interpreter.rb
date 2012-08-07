require 'absolute_renamer/interpreters/base'

module AbsoluteRenamer
  module Interpreters
    class SimpleInterpreter < Base
      def initialize(pattern, value)
        @pattern = pattern
        @value   = value
      end

      def search_and_replace(part_name, new_value, path_handler)
        new_value.gsub @pattern, @value
      end
    end
  end
end
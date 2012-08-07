require 'absolute_renamer/case_modifier'

module AbsoluteRenamer
  module Interpreters
    class Base
      include CaseModifier

      # Raised when an interpreter does not implement a required method
      class NotImplementedMethod < Error; end

      def search_and_replace(part_name, part_value, path_handler)
        raise NotImplementedMethod,
              "Interpreter #{self.class} does not implement search_and_replace"
      end

      def matcher(str)
        /\[(?<modifier>[\$\*%&])?#{str}\]/
      end
    end
  end
end

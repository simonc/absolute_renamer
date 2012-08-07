require 'absolute_renamer/interpreters/base'

module AbsoluteRenamer
  module Interpreters
    class OriginalFilenameInterpreter < Base

      def search_and_replace(part_name, new_value, path_handler)
        original_value = path_handler.send(part_name)

        new_value.gsub(/\$/) { original_value }
                 .gsub(/&/)  { original_value.upcase }
                 .gsub(/%/)  { original_value.downcase }
                 .gsub(/\*/) { camelcase original_value }
      end

    end
  end
end
require 'absolute_renamer/interpreters/base'

module AbsoluteRenamer
  module Interpreters
    class FilenamePartsInterpreter < Base

      def search_and_replace(part_name, new_value, path_handler)
        current_value = path_handler.send(part_name)
        new_value.gsub pattern do
          start  = $~[:start].to_i - 1
          length = ($~[:length] || current_value.length).to_i
          stop   = ($~[:stop] || -1).to_i

          val = case $~[:action]
          when ';' then current_value[start, length]
          when '-' then current_value[start..stop]
          else          current_value[start]
          end

          modify_case val, $~[:modifier]
        end
      end

      # Pattern for the following cases:
      #
      # * [42]
      # * [42;2]
      # * [42-]
      # * [42-45]
      #
      def pattern
        matcher /(?<start>\d+)           # A single integer
          (
            (?<action>;)(?<length>\d+)   # A start-length pattern
                                         # 1;10 => 10 chars from 1
          |
            (?<action>-)(?<stop>\d+)?    # A start-stop pattern
                                         # 1-5 => chars from 1 to 5
                                         # 5-  => chars from 5 to end of string
          )?/x
      end

    end
  end
end
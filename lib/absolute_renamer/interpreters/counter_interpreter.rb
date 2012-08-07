require 'absolute_renamer/interpreters/base'

module AbsoluteRenamer
  module Interpreters
    class CounterInterpreter < Base
      def initialize
        @counters = {}
      end

      def search_and_replace(part_name, new_value, path_handler)
        new_value.gsub(pattern).with_index do |_, counter|
          counter_value_for "#{part_name}:#{counter}", $~
        end
      end

      def counter_value_for(counter, m)
        initialize_counter counter, m[:start], m[:counter]
        next_value!        counter, m[:step]
      end

      def initialize_counter(counter, start, format)
        @counters[counter] ||= (start || '1').rjust(format.length, '0')
      end

      def next_value!(counter, step)
        current_value = @counters[counter].dup
        (step || 1).to_i.times { @counters[counter].next! }
        current_value
      end

      # Pattern for the following cases:
      #
      # * #
      # * ###
      # * #{42}
      # * #{42;2}
      # * ###{42;2}
      #
      def pattern
        /(?<counter>\#+)     # counter size ### => 001
         (\{
           (?<start>\d+)     # first iteration of the counter
           (;(?<step>\d+))?  # step between each iterations
         \})?/x
      end

    end
  end
end
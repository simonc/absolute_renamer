module AbsoluteRenamer
  # Calls every interpreter to generate the new value of a filename portion.
  class NameMaker
    # Public: Gets/Sets the Array of interpreters of the name_maker.
    attr_accessor :interpreters

    # Public: Initialize a NameMaker.
    #
    # interpreters - An Array of Interpreter objects (default: []).
    def initialize(interpreters = [])
      self.interpreters = interpreters
    end

    # Generates the new value of a filename portion.
    #
    # part_name    - A Symbol containing the name of the concerned
    #                portion (:name, :extension).
    # format       - The format to parse and interprete.
    # path_handler - The PathHandler for which the generation is done.
    #
    # Returns a String containing the new value of the filename portion.
    def new_value_for(part_name, format, path_handler)
      interpreters.inject(format) do |value, interpreter|
        interpreter.search_and_replace part_name, value, path_handler
      end
    end
  end
end

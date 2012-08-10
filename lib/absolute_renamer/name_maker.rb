module AbsoluteRenamer
  class NameMaker
    attr_accessor :interpreters

    def initialize(interpreters = [])
      self.interpreters = interpreters
    end

    def new_value_for(part_name, path_handler)
      new_value = path_handler.send(:"new_#{part_name}")

      interpreters.inject(new_value) do |value, interpreter|
        interpreter.search_and_replace part_name, value, path_handler
      end
    end
  end
end

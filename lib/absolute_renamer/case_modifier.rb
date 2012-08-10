module AbsoluteRenamer
  # Provides case modification methods.
  module CaseModifier

    # Modifies the case of a string based on a modifier character.
    #
    # string   - The String to modify.
    # modifier - The modifier character.
    #
    # Examples
    #
    #   modify_case "hello world", "*" #=> "Hello World"
    #   modify_case "hello world", "&" #=> "HELLO WORLD"
    #   modify_case "Hello World", "%" #=> "hello world"
    #
    #   Any other modifier will simply have no effect:
    #
    #   modify_case "wello world", "x" #=> "hello world"
    #
    # Returns a copy the string with modified case.
    def modify_case(string, modifier)
      case modifier
      when '*' then camelcase string
      when '&' then string.upcase
      when '%' then string.downcase
      else          string
      end
    end

    # Change the case of a string to camelcase.
    #
    # string - The string to camelcase.
    #
    # Examples
    #
    #   camelcase "hello world" #=> "Hello World"
    #   camelcase "heLLo wOrLd" #=> "Hello World"
    #
    # Returns a camelcase copy of the string.
    def camelcase(string)
      string.downcase
            .gsub(/(\b|([^a-zA-Z0-9']))([a-z])/) { "#{$2}" + $3.capitalize }
    end
  end
end

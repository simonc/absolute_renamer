module AbsoluteRenamer
  module CaseModifier
    def modify_case(string, modifier)
      case modifier
      when '*' then camelcase string
      when '&' then string.upcase
      when '%' then string.downcase
      else          string
      end
    end

    def camelcase(string)
      string.downcase
            .gsub(/(\b|([^a-zA-Z0-9']))([a-z])/) { "#{$2}" + $3.capitalize }
    end
  end
end

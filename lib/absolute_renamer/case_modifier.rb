module AbsoluteRenamer
  module CaseModifier
    def modify_case(str, modifier)
      case modifier
      when '*' then camelcase str
      when '&' then str.upcase
      when '%' then str.downcase
      else          str
      end
    end

    def camelcase(str)
      str.downcase
         .gsub(/(\b|([^a-zA-Z0-9']))([a-z])/) { "#{$2}" + $3.capitalize }
    end
  end
end
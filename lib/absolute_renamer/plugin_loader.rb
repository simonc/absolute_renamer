module AbsoluteRenamer
  class PluginLoader
    def initialize
      @@interpreters ||= []
    end

    def load_plugin_gems!
      plugin_gems.each do |gem_name|
        gem gem_name
        require gem_name
      end
    end

    def plugin_gems
      gems = Gem::Specification.find_all do |spec|
        spec.name =~ /absolute_renamer-.*/
      end

      gems.map(&:name).uniq
    end

    def interpreters
      @@interpreters
    end

    def register(interpreter)
      @@interpreters << interpreter
    end
  end
end
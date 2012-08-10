module AbsoluteRenamer
  class PathHandler
    attr_reader :path

    attr_writer :new_name
    attr_writer :new_extension

    def initialize(path, config)
      @config        = config
      @path          = path
      @directory     = File.directory?(@path)
    end

    def <=>(other)
      dirname == other.dirname ? name <=> other.name : other.dirname <=> dirname
    end

    def directory?
      @directory
    end

    def dirname
      @dirname ||= File.dirname(@path)
    end

    def extension
      @extension ||= (filename[/(\.[^\.]+){1,#{@config[:dots]}}$/] || '')[1..-1]
    end

    def filename
      @filename ||= File.basename(@path)
    end

    def name
      @name ||= directory? ? filename : filename.chomp(".#{extension}")
    end

    def new_extension
      @new_extension || extension
    end

    def new_filename
      parts = [new_name]
      parts << new_extension unless @config[:'no-extension']
      parts.join '.'
    end

    def new_name
      @new_name || name
    end

    def new_path(destination = nil)
      File.join (destination || dirname), new_filename
    end

    def rename!(renamer)
      renamer.rename self
    end

    def set_new_extension!(name_maker)
      unless @config[:'no-extension']
        self.new_extension = name_maker.new_value_for(:extension,
                                                      @config[:'ext-format'],
                                                      self)
      end
    end

    def set_new_name!(name_maker)
      self.new_name = name_maker.new_value_for(:name, @config[:format], self)
    end

    def set_new_path!(name_maker)
      set_new_name! name_maker
      set_new_extension! name_maker
    end
  end
end

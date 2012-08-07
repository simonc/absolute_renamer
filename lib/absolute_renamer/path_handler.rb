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

    def dirname
      @dirname ||= File.dirname(@path)
    end

    def new_path
      destination = @config[:destination] || location
      File.join destination, new_filename
    end

    def location
      @location ||= File.dirname(@path)
    end

    def directory?
      @directory
    end

    def new_name
      @new_name ||= @config[:format]
    end

    def new_extension
      @new_extension ||= @config[:'ext-format']
    end

    def filename
      @filename ||= File.basename(@path)
    end

    def name
      @name ||= directory? ? filename : filename.chomp(".#{extension}")
    end

    def extension
      @extension ||= (filename[/(\.[^\.]+){1,#{@config[:dots]}}$/] || '')[1..-1]
    end

    def new_filename
      parts = [new_name]
      parts << new_extension if set_extension?
      parts.join '.'
    end

    def set_new_path!(name_maker)
      self.new_name = name_maker.new_value_for(:name, self)

      if set_extension?
        self.new_extension = name_maker.new_value_for(:extension, self)
      end
    end

    def set_extension?
      extension && !@config[:'no-extension']
    end

    def rename!(renamer)
      renamer.rename self
    end

    def depth
      @depth ||= @zpath.split('/').size
    end

    def <=>(other)
      dirname == other.dirname ? name <=> other.name : other.dirname <=> dirname
    end
  end
end

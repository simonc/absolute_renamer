module AbsoluteRenamer
  # Wraps a file to provide useful informations about it.
  class PathHandler
    # Public: Gets the String path of the path_handler.
    attr_reader :path

    # Public: Sets the String new_name of the path_handler.
    attr_writer :new_name
    # Public: Sets the String new_extension of the path_handler.
    attr_writer :new_extension

    # Public: Initialize a PathHandler.
    #
    # path   - The path to the file to wrap.
    # config - A configuration storage.
    def initialize(path, config)
      @config        = config
      @path          = path
      @directory     = File.directory?(@path)
    end

    # Public: Comparison.
    #
    # If two path_handlers have the same dirname, they will be sorted by name,
    # otherwise they will be sorted by dirname.
    #
    # other - The PathHandler to compare with.
    #
    # Returns an integer (-1, 0 or +1) if this path_handler is less than, equal
    # to or greater than other.
    def <=>(other)
      dirname == other.dirname ? name <=> other.name : other.dirname <=> dirname
    end

    # Public: Tells if a PathHandler wraps a directory or not.
    #
    # Examples
    #
    #   PathHandler.new("/path/to/dir", {}).directory?     #=> true
    #   PathHandler.new("/path/to/file.rb". {}).directory? #=> false
    def directory?
      @directory
    end

    # Public: Gets the dirname of the path_handler.
    #
    # Examples
    #
    #   ph = PathHandler.new("/path/to/some/file.rb", dots: 1)
    #   ph.dirname #=> "/path/to/some"
    #
    # Returns the String dirname of the path_handler's path.
    def dirname
      @dirname ||= File.dirname(@path)
    end

    # Public: Gets the extension of the path_handler.
    #
    #   ph = PathHandler.new("/path/to/some/file.rb", dots: 1)
    #   ph.extension #=> "rb"
    #
    # Returns the String extension of the path_handler's path.
    def extension
      @extension ||= (filename[/(\.[^\.]+){1,#{@config[:dots]}}$/] || '')[1..-1]
    end

    # Public: Gets the filename of the path_handler.
    #
    # Examples
    #
    #   ph = PathHandler.new("/path/to/some/file.rb", {})
    #   ph.filename #=> "file.rb"
    #
    # Returns the String basename of the path_handler's path.
    def filename
      @filename ||= File.basename(@path)
    end

    # Public: Gets the name of the path_handler.
    #
    #   ph = PathHandler.new("/path/to/some/file.rb", dots: 1)
    #   ph.name #=> "file"
    #
    # Returns the String name of the path_handler's path.
    def name
      @name ||= directory? ? filename : filename.chomp(".#{extension}")
    end

    # Public: Gets the new_extension of the path_handler.
    #
    # If new_extension has not been modified, this method will return the same
    # value than PathHandler#extension.
    #
    # Returns the String new_extension of the path_handler.
    def new_extension
      @new_extension || extension
    end

    # Public: Gets the new_filename of the path_handler.
    #
    # If neither of new_extension or new_name has been modified, this method
    # will return the same value than PathHandler#filename.
    #
    # Returns the String new_filename of the path_handler.
    def new_filename
      parts = [new_name]
      parts << new_extension unless @config[:'no-extension']
      parts.compact.join '.'
    end

    # Public: Gets the new_name of the path_handler.
    #
    # If new_name has not been modified, this method will return the same
    # value than PathHandler#name.
    #
    # Returns the String new_name of the path_handler.
    def new_name
      @new_name || name
    end

    # Public: Gets the new_path of the path_handler.
    #
    # If destination is nil, it will default to the original location of the
    # path.
    #
    # destination - The directory in which to place the new path
    #               (default: nil).
    #
    # Examples
    #
    #   ph = PathHandler.new("/path/to/some/file.rb")
    #   
    #   ph.new_path                    #=> "/path/to/some/file.rb"
    #   ph.new_path("/some/other/dir") #=> "/some/other/dir/file.rb"
    #
    # Returns the new generated String path of the path_handler's path.
    def new_path(destination = nil)
      File.join (destination || dirname), new_filename
    end

    # Public: Renames the path_handler using renamer.
    #
    # This method will tell the renamer to actually rename the path_handler.
    # renamer can be an instance of Renamer but can be an instance of any class
    # implementing the rename(path_handler) method.
    #
    # renamer - An object capable of renaming a path_handler. It must respond to
    #           rename(path_handler).
    #
    # Returns nothing.
    def rename!(renamer)
      renamer.rename self
    end

    # Public: Sets the new_extension of the path_handler using a name_maker.
    #
    # name_maker - A NameMaker containing a list of Interpreter objects that
    #              will genereate a new value for the new_extension.
    #
    # Returns nothing.
    def set_new_extension!(name_maker)
      unless @config[:'no-extension']
        self.new_extension = name_maker.new_value_for(:extension,
                                                      @config[:'ext-format'],
                                                      self)
      end
    end

    # Public: Sets the new_name of the path_handler using a name_maker.
    #
    # name_maker - A NameMaker containing a list of Interpreter objects that
    #              will genereate a new value for the new_name.
    #
    # Returns nothing.
    def set_new_name!(name_maker)
      self.new_name = name_maker.new_value_for(:name, @config[:format], self)
    end

    # Public: Sets the new_extension and new_name of the path_handler using
    # a name_maker.
    #
    # name_maker - A NameMaker containing a list of Interpreter objects that
    #              will genereate new values for the new_extension and the
    #              new_name.
    #
    # Returns nothing.
    def set_new_path!(name_maker)
      set_new_name! name_maker
      set_new_extension! name_maker
    end
  end
end

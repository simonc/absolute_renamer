require 'fileutils'

module AbsoluteRenamer
  class Renamer
    MODES = {
      :copy    => :cp_r,
      :link    => :ln,
      :move    => :mv,
      :symlink => :ln_s
    }

    attr_writer :mode

    def initialize(config)
      @config = config
    end

    def mode
      @mode ||= renaming_mode(@config[:mode])
    end

    def rename(path_handler)
      FileUtils.send mode,
                     path_handler.path,
                     path_handler.new_path,
                     verbose: true,
                     noop: @config.list?
    end

    private

    def renaming_mode(mode)
      MODES[mode] || raise(RenamingModeUnknown, "#{mode} is not a renaming mode")
    end

    def short_path(path)
      path.sub Dir.pwd+'/', ''
    end
  end
end

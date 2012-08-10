require 'fileutils'

module AbsoluteRenamer
  class Renamer
    MODES = {
      :copy    => :cp_r,
      :link    => :ln,
      :move    => :mv,
      :symlink => :ln_s
    }

    def rename(path_handler, mode, destination = nil, options = {})
      FileUtils.send renaming_mode(mode),
                     path_handler.path,
                     path_handler.new_path(destination),
                     options
    end

    def renaming_mode(mode)
      MODES[mode] || raise(RenamingModeUnknown, "#{mode} is not a renaming mode")
    end
  end
end

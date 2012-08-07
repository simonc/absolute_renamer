module AbsoluteRenamer
  # The main Error class, all Exception classes inherit from this class.
  class Error < StandardError; end

  # Raised when the renaming mode is not a known one
  class RenamingModeUnknown < Error; end

  require 'absolute_renamer/plugin_loader'
  require 'absolute_renamer/renamer'
  require 'absolute_renamer/path_handler'
  require 'absolute_renamer/interpreters'
  require 'absolute_renamer/name_maker'
end
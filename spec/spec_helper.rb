$:.unshift File.expand_path('../../lib', __FILE__)

require 'absolute_renamer'

module AbsoluteRenamer
  Settings.settings = Settings::DEFAULT_SETTINGS
end
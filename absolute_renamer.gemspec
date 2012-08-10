# -*- encoding: utf-8 -*-
require File.expand_path('../lib/absolute_renamer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Simon COURTOIS"]
  gem.email         = ["scourtois@cubyx.fr"]
  gem.summary       = "absolute_renamer is a very powerful tool that helps " \
                      "files and directories renaming using the Krename syntax."

  gem.description   = "absolute_renamer is a very powerful tool that helps " \
                      "files and directories renaming using the Krename "    \
                      "syntax. Unlike many batch renaming tools, "           \
                      "absolute_renamer is able to rename folders. "         \
                      "absolute_renamer is modular and can be extended to "  \
                      "add new format tokens to handle mp3 or images or "    \
                      "movies or any other type of file."

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "absolute_renamer"
  gem.require_paths = ["lib"]
  gem.version       = AbsoluteRenamer::VERSION

  gem.add_development_dependency "rspec", "~> 2.6.0"
  gem.add_development_dependency "simplecov", "~> 0.6.4"
  gem.add_runtime_dependency "slop", "~> 3.3.2"
end

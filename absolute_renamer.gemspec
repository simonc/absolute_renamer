# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "absolute_renamer/version"

Gem::Specification.new do |s|
  s.name        = "absolute_renamer"
  s.version     = AbsoluteRenamer::VERSION
  s.authors     = ["Simon COURTOIS"]
  s.email       = ["happynoff@free.fr"]
  s.homepage    = "http://github.com/simonc/absolute_renamer"

  s.summary     = "absolute_renamer is a very powerful tool that helps files "  \
                  "and directories renaming using the Krename syntax."

  s.description = "absolute_renamer is a very powerful tool that helps files "  \
                  "and directories renaming using the Krename syntax. Unlike " \
                  "many batch renaming tools, absolute_renamer is able to "     \
                  "rename folders. AbsoluteRenamer is modular and can be "     \
                  "extended to adapt itself to any kind of file or to add "    \
                  "new options and features."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.has_rdoc         = true
  s.extra_rdoc_files = ['LICENSE', 'README.rdoc']
  s.rdoc_options     = ["--charset=UTF-8"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end

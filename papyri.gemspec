# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "papyri/version"

Gem::Specification.new do |s|
  s.name        = "papyri"
  s.version     = Papyri::VERSION
  s.authors     = ["wilkie"]
  s.email       = ["wilkie05@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "papyri"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'rake', '>= 0.8.7'
  s.add_runtime_dependency 'tilt', '>= 0.9'

  s.add_development_dependency 'rspec', '>= 2.4'
end

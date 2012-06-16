# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "database_loader/version"

Gem::Specification.new do |s|
  s.name        = "database_loader"
  s.version     = DatabaseLoader::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Edgars Beigarts"]
  s.email       = ["1@wb4.lv"]
  s.homepage    = "http://github.com/ebeigarts/database_loader"
  s.description = %q{Load SQL views, materialized views, grants, etc. into database}
  s.summary     = s.description

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency(%q<rspec>, ["~> 2.8.0"])
  s.add_dependency(%q<activesupport>, [">= 0"])
end

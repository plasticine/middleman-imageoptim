# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require File.expand_path('../lib/middleman-imageoptim/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "middleman-imageoptim"
  gem.version     = MiddlemanImageoptim::VERSION
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ["Justin Morris"]
  gem.email       = ["desk@pixelbloom.com"]
  gem.homepage    = "http://pixelbloom.com"
  gem.summary     = %q{A short summary of your extension}
  gem.description = %q{A longer description of your extension}

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency("middleman-core", [">= 3.0"])
  gem.add_runtime_dependency("image_optim", "~> 0.8.0")
end

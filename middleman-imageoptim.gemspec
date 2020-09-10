# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require File.expand_path('../lib/middleman-imageoptim/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = Middleman::Imageoptim::PACKAGE
  gem.version       = Middleman::Imageoptim::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ['Justin Morris']
  gem.email         = ['desk@pixelbloom.com']
  gem.homepage      = 'https://github.com/plasticine/middleman-imageoptim'
  gem.summary       = 'Small images are small! Compress yours during middleman build.'
  gem.description   = 'Small images are small! Compress yours during middleman build.'
  gem.license       = 'MIT'
  gem.files         = `git ls-files`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency 'middleman-core', ['>= 3.1']
  gem.add_dependency 'middleman-cli'
  gem.add_dependency 'image_optim', '~> 0.25.0'
  gem.add_dependency 'image_optim_pack', '~> 0.2.1'

  gem.add_development_dependency 'appraisal'
  gem.add_development_dependency 'aruba'
  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '>= 3.0.0'
  gem.add_development_dependency 'rspec-its'
  gem.add_development_dependency 'rubocop'
  gem.add_development_dependency 'capybara'
  gem.add_development_dependency 'simplecov'
end

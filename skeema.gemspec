# -*- encoding: utf-8 -*-
require File.expand_path('../lib/skeema/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Solomon White"]
  gem.email         = ["rubysolo@gmail.com"]
  gem.description   = %q{Skeema}
  gem.summary       = %q{Skeema is an experiment in different methods of parsing ActiveRecord schema.rb files}
  gem.homepage      = "https://github.com/rubysolo/skeema"

  gem.add_development_dependency 'pry-nav'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "skeema"
  gem.require_paths = ["lib"]
  gem.version       = Skeema::VERSION
end

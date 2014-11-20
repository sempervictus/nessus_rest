# -*- encoding: utf-8 -*-

require File.expand_path('../lib/nessus_rest/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "nessus_rest"
  gem.version       = NessusREST::VERSION
  gem.summary       = %q{Interact with Nessus REST API}
  gem.description   = %q{Wrappers and convenience methods around Nestful REST queries}
  gem.license       = "MIT"
  gem.authors       = ["RageLtMan"]
  gem.email         = "rageltman [at] sempervictus"
  gem.homepage      = "https://rubygems.org/gems/nessus_rest"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency     'nestful', '>= 1.0.7'

  gem.add_development_dependency 'rdoc', '~> 3.0'
  gem.add_development_dependency 'rspec', '~> 2.4'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
end

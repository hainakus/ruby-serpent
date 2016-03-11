$:.push File.expand_path("../lib", __FILE__)

require 'serpent/version'

Gem::Specification.new do |s|
  s.name        = "serpent"
  s.version     = Serpent::VERSION
  s.authors     = ["Jan Xie"]
  s.email       = ["jan.h.xie@gmail.com"]
  s.homepage    = "https://github.com/janx/ruby-serpent"
  s.summary     = "Ruby binding to Ethereum Serpent compiler."
  s.description = "Serpent is a Python style smart contract language."
  s.license     = 'MIT'

  s.files = Dir["{lib}/**/*"] + ["LICENSE", "README.md"]

  s.add_development_dependency('rake', '~> 10.5.0')
  s.add_development_dependency('rake-compiler', '~> 0.9.5')
  s.add_development_dependency('rice', '~> 2.1.0')
  s.add_development_dependency('minitest', '5.8.3')
  s.add_development_dependency('yard', '0.8.7.6')
end

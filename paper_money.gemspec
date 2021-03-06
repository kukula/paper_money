# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "paper/version"

Gem::Specification.new do |spec|
  spec.name          = "paper_money"
  spec.version       = Paper::VERSION
  spec.authors       = ["Anatoliy Kukul"]
  spec.email         = ["anatolkukula@gmail.com"]

  spec.summary       = %q{Paper::Money gem helps with money conversion, comparison and arithmetic}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/kukula/paper_money"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
end

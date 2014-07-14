$:.push File.expand_path('../lib', __FILE__)
require 'bookdepository/version'

Gem::Specification.new do |s|
  s.name     = 'bookdepository'
  s.version  = Bookdepository::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors  = ['Hakan Ensari']
  s.email    = ['me@hakanensari.com']
  s.homepage = 'https://github.com/hakanensari/bookdepository'
  s.summary  = 'Bookdepository.com API wrapper'
  s.license  = 'MIT'

  s.files         = Dir.glob('lib/**/*') + %w(LICENSE README.md)
  s.test_files    = Dir.glob('test/**/*')
  s.require_paths = ['lib']

  s.add_runtime_dependency 'countries'
  s.add_runtime_dependency 'excon'
  s.add_runtime_dependency 'multi_xml'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'vcr'

  s.required_ruby_version = '>= 1.9'
end

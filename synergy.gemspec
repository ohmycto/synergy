# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'synergy'
  s.version     = '1.3.0'
  s.summary     = 'Russian e-commerce solution based on Spree'
  s.description = ''
  s.required_ruby_version = '>= 1.8.7'

  # s.author    = 'You'
  # s.email     = 'you@example.com'
  # s.homepage  = 'http://www.spreecommerce.com'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.3.0'
  s.add_dependency 'spree_auth_devise'
  s.add_dependency 'spree_i18n'
  s.add_dependency 'russian'
  s.add_dependency 'spree_editor', '>= 1.0.1'
end

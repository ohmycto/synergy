# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'synergy'
  s.version     = '1.3.0'
  s.summary     = 'Russian e-commerce solution based on Spree'
  s.description = ''
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Roman Smirnov'
  s.email             = 'roman@railsdog.com'
  s.homepage          = 'https://github.com/secoint/synergy'
  s.rubyforge_project = 'synergy'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree', '~> 1.3.0'
  s.add_dependency 'spree_auth_devise'
  s.add_dependency 'spree_i18n'
  s.add_dependency 'russian'
  s.add_dependency 'spree_editor', '>= 1.0.1'
  s.add_dependency 'synergy_inventory_management', '~> 1.3.0'
  s.add_dependency 'spree_static_content'
  s.add_dependency 'spree_online_support', '~> 1.3.0'
  s.add_dependency 'spree_address_book', '~> 1.3.0'
end

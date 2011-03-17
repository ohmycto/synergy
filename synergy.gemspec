Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'synergy'
  s.version     = '0.50.0.rc0'
  s.summary     = 'Russian e-commerce solution based on Spree'
  #s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Roman Smirnov'
  s.email             = 'roman@railsdog.com'
  # s.homepage          = 'http://www.rubyonrails.org'
  # s.rubyforge_project = 'actionmailer'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = true

  s.add_dependency('russian')
  s.add_dependency('json')
  s.add_dependency('spree', '>= 0.40.99')
  s.add_dependency('spree_i18n')
  s.add_dependency('spree_static_content', '>= 0.40.0')
  s.add_dependency('spree_editor')
  s.add_dependency('spree_enhanced_option_types', '>= 0.30.0')
  s.add_dependency('spree_robokassa')
  s.add_dependency('spree_yandex_market')
  s.add_dependency('spree_online_support')
  s.add_dependency('spree_address_book')
end

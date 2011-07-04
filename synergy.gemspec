Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'synergy'
  s.version     = '0.60.0'
  s.summary     = 'Russian e-commerce solution based on Spree'
  s.description = ''
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Roman Smirnov'
  s.email             = 'roman@railsdog.com'
  s.homepage          = 'https://github.com/secoint/synergy'
  s.rubyforge_project = 'synergy'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('synergy_russian', '0.2.8')
  s.add_dependency('json', '~> 1.5.1')
  s.add_dependency('nokogiri', '~> 1.4.4')
  s.add_dependency('spree', '~> 0.60.0')
  s.add_dependency('spree_static_content', '~> 0.60.1')
  s.add_dependency('spree_editor', '~> 0.50.1')
  s.add_dependency('spree_robokassa', '~> 0.50.2')
  s.add_dependency('spree_yandex_market', '~> 1.2.0')
  s.add_dependency('spree_online_support', '~> 0.50.0')
  s.add_dependency('spree_address_book', '~> 0.50.1')
  s.add_dependency('spree_dynamic_sitemaps', '~> 0.50.1')
end

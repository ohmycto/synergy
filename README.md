Synergy
============


Установка
============

1. Установите Rails 3.2.12
    
        gem install rails -v 3.2.12
    
1. Создайте новое приложение
    
        rails new synergy_app
    
1. Настройте подключение к базе данных (рекомендуется MySQL с адаптером mysql2)
1. Добавьте в Gemfile следующие строки:
        
        gem 'russian'
        gem 'spree', '~> 1.3.0'
        gem 'spree_auth_devise', :git => 'git://github.com/spree/spree_auth_devise', :branch => '1-3-stable'
        gem 'spree_i18n', :git => 'git://github.com/spree/spree_i18n.git', :branch => '1-3-stable'
        gem 'spree_static_content', :git => 'git://github.com/spree/spree_static_content.git', :branch => '1-3-stable'
        gem 'ckeditor'
        gem 'spree_editor', :git => 'git://github.com/secoint/spree_editor.git'
        gem 'synergy_inventory_management', :git => 'git://github.com/secoint/synergy_inventory_management.git'
        gem 'spree_online_support', :git => 'git://github.com/secoint/spree_online_support.git'
        gem 'synergy', :git => 'git://github.com/secoint/synergy.git', :branch => '1-3-x'
    
1. Выполните следующие команды:
    
        bundle install
        rails g synergy:install

1. Аналогично Spree, можно использовать следующие параметры (по умолчанию true):

        rails g synergy:install --migrate=false --sample=false --seed=false
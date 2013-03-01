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
        
        gem 'synergy', :git => 'git://github.com/secoint/synergy.git', :branch => '1-3-x'
        gem 'spree_auth_devise', :git => 'git://github.com/spree/spree_auth_devise', :branch => '1-3-stable'
        gem 'spree_i18n', :git => 'git://github.com/secoint/spree_i18n.git', :branch => '1-3-stable'
        gem 'spree_static_content', :git => 'git://github.com/spree/spree_static_content.git', :branch => '1-3-stable'
        gem 'spree_editor', :git => 'git://github.com/secoint/spree_editor.git'
        gem 'spree_online_support', :git => 'git://github.com/secoint/spree_online_support.git'
        gem 'spree_address_book', :git => 'git://github.com/romul/spree_address_book.git'
    
1. Выполните следующие команды:
    
        bundle install
        rails g synergy:install

1. Аналогично Spree, можно использовать следующие параметры (по умолчанию true):

        rails g synergy:install --migrate=false --sample=false --seed=false
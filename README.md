Synergy
=======

Решение для создания российских интернет-магазинов, основанное на Spree.


Установка
=========

1. Установите Rails 3.1.3
    
        gem install rails -v 3.1.3
    
1. Создайте новое приложение
    
        rails new synergy_app -GJTq
    
1. Настройте подключение к базе данных (рекомендуется MySQL с адаптером mysql2)
1. Добавьте в Gemfile следующие строки:
    
        gem 'mysql2', '~> 0.3.11'
        gem 'active_reload'
        gem 'synergy', '~> 0.70.0', :git => 'git://github.com/secoint/synergy.git'
        gem 'spree_i18n', :git => 'git://github.com/spree/spree_i18n.git'
        gem 'spree_blue_theme', :git => 'git://github.com/spree/spree_blue_theme.git', :branch => '0-70-stable'
        # gem 'synergy_default_theme', '~> 1.0.2'
    
1. Выполните следующие команды:
    
        bundle install
        rails g spree:site
        rails g spree_static_content:install
        rails g spree_editor:install
        rails g spree_address_book:install
        rails g synergy:install
        rake db:migrate
        rake db:seed db:sample
        rails s
    

Copyright (c) 2011 Roman Smirnov, released under the GNU GPL v3

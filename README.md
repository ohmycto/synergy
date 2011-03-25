Synergy
=======

Решение для создания российских интернет-магазинов, основанное на Spree.


Установка
=========

1. Установите Rails 3.0.5
    
        gem install rails -v 3.0.5
    
1. Создайте новое приложение
    
        rails new synergy_app -GJTq
    
1. Настройте подключение к базе данных (рекомендуется MySQL с адаптером mysql2)
1. Добавьте в Gemfile следующие строки:
    
        gem 'spree', :git => 'git://github.com/spree/spree.git', :branch => '0-50-stable'
        gem 'spree_i18n', :git => 'git://github.com/spree/spree_i18n.git'
        gem 'spree_static_content', :git => 'git://github.com/spree/spree_static_content.git'
        gem 'spree_editor', :git => 'git://github.com/romul/spree_editor.git'
        gem 'spree_online_support', :git => 'git://github.com/secoint/spree_online_support.git'
        gem 'spree_robokassa', :git => 'git://github.com/romul/spree_robokassa.git'
        gem 'spree_yandex_market', :git => 'git://github.com/romul/spree-yandex-market.git'
        gem 'spree_address_book', :git => 'git://github.com/romul/spree_address_book.git'
        gem 'spree_enhanced_option_types', :git => 'git://github.com/romul/spree-enhanced-option-types.git'
        gem 'synergy', :git => 'git://github.com/secoint/synergy.git'
    
1. Выполните следующие команды:
    
        bundle install
        rails g spree:site -f
        rake spree:install
        rake synergy:install
        rake db:migrate
        rake db:seed db:sample
        rails s


Обновление
==========

        bundle update
        rake synergy:install
        rake db:migrate
        rails s
    

Copyright (c) 2011 Roman Smirnov, released under the GNU GPL v3

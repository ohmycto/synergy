Synergy
=======

Решение для создания российских интернет-магазинов, основанное на Spree.


Установка
=========

1. Установите Rails 3.0.9
    
        gem install rails -v 3.0.9
    
1. Создайте новое приложение
    
        rails new synergy_app -GJTq
    
1. Настройте подключение к базе данных (рекомендуется MySQL с адаптером mysql2)
1. Добавьте в Gemfile следующие строки:
    
        gem 'mysql2', '~> 0.2.7'
        gem 'spree', :git => 'git://github.com/spree/spree.git', :branch => '0-60-stable'
        gem 'spree_i18n', :git => 'git://github.com/spree/spree_i18n.git'
        gem 'synergy', '~> 0.60.0'
        gem 'synergy_default_theme', '~> 1.0.2'
    
1. Выполните следующие команды:
    
        bundle install
        rails g spree:site -f
        rake spree:install
        rake synergy:install
        rake synergy_default_theme:install
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

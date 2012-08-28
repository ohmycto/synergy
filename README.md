Synergy
=======

Решение для создания российских интернет-магазинов, основанное на Spree.


Установка
=========

1. Установите Rails 3.1.6

        gem install rails -v 3.1.6

1. Создайте новое приложение

        rails _3.1.6_ new synergy_app -GJTq

1. Настройте подключение к базе данных (рекомендуется MySQL с адаптером mysql2)
1. Добавьте в Gemfile следующие строки:

        gem 'mysql2', '~> 0.3.11'
        gem 'spree', :git => 'git://github.com/secoint/spree.git', :branch => '0-70-stable'
        gem 'spree_i18n', :git => 'git://github.com/secoint/spree_i18n.git'
        gem 'synergy', :git => 'git://github.com/secoint/synergy.git', :branch => '0-70-stable'
        gem 'synergy_default_theme', :git => 'https://github.com/romul/synergy_default_theme.git', :branch => '0-70-x'

1. Выполните следующие команды для установки расширений и заполнения базы начальными данными:

        bundle install
        rails g spree:site
        rails g spree_static_content:install
        rails g spree_editor:install
        rails g spree_address_book:install
        rails g synergy:install
        rake db:migrate
        rake db:seed db:sample
        rails s


Copyright (c) 2012 Roman Smirnov, Denis Lukyanov, Service & Consulting, released under the GNU GPL v3


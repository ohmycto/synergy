require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/packagetask'
require 'rake/gempackagetask'

gemfile = File.expand_path('../spec/test_app/Gemfile', __FILE__)
if File.exists?(gemfile) && (%w(spec cucumber).include?(ARGV.first.to_s) || ARGV.size == 0)
  require 'bundler'
  ENV['BUNDLE_GEMFILE'] = gemfile
  Bundler.setup

  require 'rspec'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new

  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new do |t|
    t.cucumber_opts = %w{--format progress}
  end
end

desc "Default Task"
task :default => [:spec, :cucumber ]

spec = eval(File.read('synergy.gemspec'))

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc "Release to gemcutter"
task :release => :package do
  require 'rake/gemcutter'
  Rake::Gemcutter::Tasks.new(spec).define
  Rake::Task['gem:push'].invoke
end

desc "Default Task"
task :default => [ :spec ]

desc "Regenerates a rails 3 app for testing"
task :test_app do
  require '../spree/lib/generators/spree/test_app_generator'
  class SynergyTestAppGenerator < Spree::Generators::TestAppGenerator

    def install_gems
      inside "test_app" do
        run 'rake spree:install'
        run 'rake synergy:install'
      end
    end

    def migrate_db
      run_migrations
    end

    protected
    def full_path_for_local_gems
      <<-gems
gem 'spree',   :path => \'#{File.join(File.dirname(__FILE__), "../spree")}\'
gem 'synergy', :path => \'#{File.dirname(__FILE__)}\'
      gems
    end

  end
  SynergyTestAppGenerator.start
end

namespace :test_app do
  desc 'Rebuild test and cucumber databases'
  task :rebuild_dbs do
    system("cd spec/test_app && rake db:drop db:migrate RAILS_ENV=test && rake db:drop db:migrate RAILS_ENV=cucumber")
  end
end


module Synergy
  module Generators
    class InstallGenerator < Rails::Generators::Base

      class_option :migrate, :type => :boolean, :default => true, :banner => 'Run migrations'
      class_option :seed, :type => :boolean, :default => true, :banner => 'Load seed data (migrations must be run)'
      class_option :sample, :type => :boolean, :default => true, :banner => 'Load sample data (migrations must be run)'

      def prepare_options
        @run_migrations = options[:migrate]
        if @run_migrations
          @load_seed_data = options[:seed]
          @load_sample_data = options[:sample]
        else
          @load_seed_data = @load_sample_data = false
        end
      end

      def install_spree
        generate "spree:install --migrate=#{@run_migrations} --seed=false --sample=#{@load_sample_data} --user_class=Spree::User"
      end

      def replace_seed_data
        gsub_file(File.join(Rails.root, 'db', 'seeds.rb'), /#{Regexp.escape('Spree::Core::Engine.load_seed if defined?(Spree::Core)')}/, "Synergy::Engine.load_seed")
      end

      def load_seed_data
        if @load_seed_data
          rake 'db:seed'
        end
      end

      # def add_javascripts
      #   append_file 'app/assets/javascripts/store/all.js', "//= require store/synergy\n"
      #   append_file 'app/assets/javascripts/admin/all.js', "//= require admin/synergy\n"
      # end

      # def add_stylesheets
      #   inject_into_file 'app/assets/stylesheets/store/all.css', " *= require store/synergy\n", :before => /\*\//, :verbose => true
      #   inject_into_file 'app/assets/stylesheets/admin/all.css', " *= require admin/synergy\n", :before => /\*\//, :verbose => true
      # end
    end
  end
end

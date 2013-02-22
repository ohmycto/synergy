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
        say_status :installing, 'Spree'
        generate "spree:install --migrate=false --seed=false --sample=false --user_class=Spree::User"
      end

      def replace_seed_data
        quietly { gsub_file(File.join(Rails.root, 'db', 'seeds.rb'), /#{Regexp.escape('Spree::Core::Engine.load_seed if defined?(Spree::Core)')}/, "Synergy::Engine.load_seed") }
      end

      def install_spree_static_content
        say_status :installing, 'Spree Static Content'
        # no need to do anything, migrations will be copied during Spree installation
      end

      def install_spree_editor
        say_status :installing, 'CKEditor'
        quietly { generate 'ckeditor:install --orm=active_record --backend=paperclip' }
      end

      def install_synergy_inventory_management
        say_status :installing, 'Synergy Inventory Management'
        quietly { generate 'synergy_inventory_management:install' }
      end

      def install_spree_online_support
        say_status :installing, 'Spree Online Support'
        # nothing to do
      end

      def install_spree_address_book
        say_status :installing, 'Spree Address Book'
        quietly { generate 'spree_address_book:install' }
      end

      def run_migrations
        if @run_migrations
          say_status :running, 'migrations'
          quietly { rake 'db:migrate' }
        end
      end

      def load_seed_data
        if @load_seed_data
          say_status :loading,  'seed data'
          rake 'db:seed'
        end
      end

      def load_sample_data
        if @load_sample_data
          say_status :loading, 'sample data'
          quietly { rake 'spree_sample:load' }
          quietly { Spree::Price.update_all(:currency => 'RUB') }
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

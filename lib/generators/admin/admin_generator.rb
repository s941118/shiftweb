require "rails/generators/resource_helpers"

module Rails
  module Generators
		class AdminGenerator < Rails::Generators::NamedBase
		  source_root File.expand_path('templates', __dir__)
      include ResourceHelpers
      check_class_collision suffix: "Controller"
		  class_option :namespace, type: :string, default: 'admin'
		  class_option :orm, default: 'admin', banner: "NAME", type: :string, required: true,
                         desc: "ORM to generate the controller for"
      argument :attributes, type: :array, default: [], banner: "field:type field:type"

		  def create_namespace_controller_file
		  	template "#{options[:namespace]}_controller.rb", "app/controllers/#{options[:namespace]}_controller.rb"
		  end

		  def create_namespace_policy_file
		  	template "#{options[:namespace]}_policy.rb", "app/policies/#{options[:namespace]}/#{singular_name}_policy.rb"
		  end

      def create_css_file
        template "#{options[:namespace]}.scss", "app/assets/stylesheets/#{options[:namespace]}.scss"
      end

      def create_admin_layout_file
        template "#{options[:namespace]}.html.erb", "app/views/layouts/#{options[:namespace]}.html.erb"
      end

      def create_admin_nav_file
        template '_nav_top.html.erb', "app/views/#{options[:namespace]}/common/_nav_top.html.erb"
      end

      def create_admin_routes
        inject_into_file 'config/routes.rb', before: /^end/ do
          "\n\tget 'admin', to: redirect('/')\n\t" +
          "namespace :#{options[:namespace]} do\n" +
          "\t\tresources :#{plural_name}\n" +
          "\t\tget 'signin', to: 'sessions#new'\n" +
          "\t\tpost 'signin', to: 'sessions#create'\n" +
          "\t\tdelete 'logout', to: 'sessions#destroy'\n" +
          "\tend\n"
        end
      end

      ## 以下生成管理員、登入頁、登入授權

      def create_admin_user
        # creates the migration file for the model.
        generate "model", "#{singular_name} name:string password_digest:string"
      end

		  def copy_session_files
        template "signin.html.erb", "app/views/#{options[:namespace]}/sessions/new.html.erb"
        template "sessions.scss", "app/assets/stylesheets/#{options[:namespace]}/sessions.scss"
        template "session_policy.rb", "app/policies/#{options[:namespace]}/session_policy.rb"
      end

      ## 以上生成管理員、登入頁、登入授權
		end
	end
end
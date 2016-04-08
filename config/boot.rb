ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

module Rails
  require 'rails/commands/server'
  if Rails.env.development?
    class Server
      def default_options
        if Figaro.env.port?
          super.merge(Host: '0.0.0.0', Port: Figaro.env.port)
        else
          super
        end
      end
    end
  end
end

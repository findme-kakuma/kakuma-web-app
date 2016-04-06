ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

module Rails
  require 'rails/commands/server'
  if Rails.env.development?
    class Server
      def default_options
        super.merge(Host:  '0.0.0.0', Port: Figaro.env.port)
      end
    end
  end
end

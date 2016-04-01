source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use Postgres as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Figaro was written to make it easy to securely configure Rails applications.
gem 'figaro'

# Use Unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use haml as templating engine for HTML.
gem 'haml'

# Bootstrap 4 ruby gem for Ruby on Rails (Sprockets) and Compass.
gem 'bootstrap', '~> 4.0.0.alpha3'

# Bootstrap 4 : Tooltips and popovers depend on tether for positioning.
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end

# Use wicked to make your Rails controllers into step-by-step wizards.
gem 'wicked'

# Simple Form aims to be as flexible as possible while helping you with
# powerful components to create your forms.
gem 'simple_form'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a
  # debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Haml-rails provides Haml generators for Rails 4.
  gem 'haml-rails', '~> 0.9'

  # Unicorn family Rack handlers for you. Mostly for rails s.
  gem 'rack-handlers'

  ##
  # Avoid repeating yourself, use pry-rails instead of copying the initializer
  # to every rails project. This is a small gem which causes rails console to
  # open pry. It therefore depends on pry.
  gem 'pry-rails'
end

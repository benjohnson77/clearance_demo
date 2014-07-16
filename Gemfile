source "https://rubygems.org"

gem "unicorn"
gem "rails", "4.1.1"
gem "sqlite3"
gem "sass-rails", "~> 4.0.3"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.0.0"
gem "jquery-rails"
gem "bootstrap-sass", "~> 3.2.0"
gem "json", "~> 1.8.1"

gem "sdoc", "~> 0.4.0",          group: :doc

gem 'will_paginate-bootstrap'

gem "simple_form"

group :test, :development do
  gem "spring"
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "capybara"
  gem "database_cleaner", git: "git@github.com:bmabey/database_cleaner.git"
  gem "ruby_css_lint"
  gem "selenium-webdriver"

  # helps with loading fake data
  gem "faker"
  # like so that I can handle ENV vars
  gem "dotenv-rails"
end


# Pimp my dev env
guard_notifications = true
group :development do

  gem "i18n_generators"
  gem "better_errors"
  gem "binding_of_caller"
  gem "meta_request"
  gem "rails-footnotes"
  gem "annotate"
  gem "rb-fsevent"
  gem "ruby_gntp" if guard_notifications
  gem "yajl-ruby"
  gem "rack-livereload"
  gem "guard-livereload"
  gem "guard-bundler"
  gem "guard-rspec"
  gem "guard-unicorn"
  gem "pry-rails"
  gem "heroku_san"
  gem "foreman"
end

# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

gem 'rails', '~> 7.0.3'

gem 'pg', '~> 1.3.5'

gem 'bootsnap', '~> 1.12.0', require: false
gem 'pagy', '~> 5.10.1'
gem 'puma', '~> 5.6.4'
gem 'rack-cors', '~> 1.1.1'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# gem 'bcrypt', '~> 3.1.18'

group :development, :test do
  gem 'awesome_print', '~> 1.9.2', require: 'ap'
  gem 'byebug', '~> 11.1.3'
  gem 'debug', '~> 1.5.0', platforms: %i[mri mingw x64_mingw]
  gem "faker", "~> 2.21"
  gem 'rubocop', '~> 1.30.1'
  gem 'rubocop-performance', '~> 1.14.1'
  gem "rubocop-rake", "~> 0.6.0"
end

group :development do
  gem 'brakeman', '~> 5.2.3'
  gem 'bundler-audit', '~> 0.9.1'
  gem 'fastri', '~> 0.3.1.1'
  gem 'pessimize', '~> 0.4.0'
  gem 'pry', '~> 0.14.1'
  gem 'rack', '~> 2.2.3.1'
  gem 'rcodetools', '~> 0.8.5.0'
  gem 'reek', '~> 6.1.1'
  gem 'rubycritic', '~> 4.7.0'
  gem 'shotgun', '~> 0.9.2'
  gem 'shoulda-matchers', '~> 5.1.0'
  gem 'solargraph', '~> 0.45.0'
  gem 'spring', '~> 4.0.0'
end

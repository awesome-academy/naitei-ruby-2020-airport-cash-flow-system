source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

gem "bootsnap", ">= 1.4.2", require: false
gem "mysql2", ">= 0.4.4"
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.3", ">= 6.0.3.2"

group :development do
  gem "listen", "~> 3.2"
  gem "rails_best_practices"
  gem "reek"
  gem "rubocop", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)

group :development, :test do
  gem "factory_bot_rails"
  gem "pry-rails"
  gem "rspec-rails"
end

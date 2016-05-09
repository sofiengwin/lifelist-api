source "https://rubygems.org"

ruby "2.3.0"
gem "rails", "4.2.5"

gem "rails-api"
gem "bcrypt", "~> 3.1.7"
gem "jwt"
gem "active_model_serializers"

group :production do
  gem "rails_12factor"
  gem "pg"
end

group :development, :test do
  gem "sqlite3"
  gem "spring"
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "pry"
  gem "pry-nav"
  gem "database_cleaner"
  gem "faker"
  gem "shoulda-matchers"
  gem "coveralls", require: false
end

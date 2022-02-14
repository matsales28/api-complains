source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.6'
# Use Puma as the app server
gem 'puma', '~> 5.6', '>= 5.6.2'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'mongoid'
gem 'rack-cors'
gem 'airbrake'
gem 'faker'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails', '>= 6.1.0'
end

group :development do
  gem 'rubocop', '~> 0.85.1', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'solargraph'
  gem 'skunk'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'simplecov' # rubocop:todo Bundler/DuplicatedGem
  gem 'simplecov-console'
  gem 'minitest-reporters'
  gem 'database_cleaner-mongoid'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

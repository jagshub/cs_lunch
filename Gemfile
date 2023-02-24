source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.7'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# group :development, :test do
#   # Call 'byebug' anywhere in the code to stop execution and get a debugger console
#   gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
# end
#
# group :development do
#   # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
#   gem 'web-console', '>= 4.1.0'
#   # Display performance information such as SQL time and flame graphs for each request in your browser.
#   # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
#   gem 'rack-mini-profiler', '~> 2.0'
#   gem 'listen', '~> 3.3'
# end

group :development do
  gem 'annotate'                                                                # Annotate Rails classes with schema and routes info
  gem 'better_errors'                                                           # Better error page
  gem 'bullet'                                                                  # Detect N+1 queries and unused eager loading
end

group :test do
  gem 'capybara'                                                                # Browser integration testing
  gem 'database_cleaner'                                                        # Strategies for cleaning databases
  gem 'rspec-retry'                                                             # Randomly retry failing specs
  gem 'shoulda-matchers'                                                        # easier model testing
end

group :development, :test do
  gem 'brakeman'                                                                # Security vulnerability scanner
  gem 'factory_bot_rails'                                                       # Fixtures in Rails
  gem 'listen'                                                                  # Run code on file changes
  gem 'progressor', require: false                                              # Simple time measurement and long task progress
  gem 'pry'                                                                     # Interactive console
  gem 'rspec'                                                                   # Testing
  gem 'rspec-rails'                                                             # Rspec for Rails
  gem 'rubocop', require: false                                                 # Ruby linter
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

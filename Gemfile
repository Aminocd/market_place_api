source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.1.5' #Ben 6/12/2018 bumped version to get more features including yarn support which allows you to use node js modules so you can seamlessly integrate a separate react js app
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
#
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'rack-cors', require: 'rack/cors' #Ben 6/12/2018 need for cross origin resource sharing when using a separate front end app
# Use jquery as the JavaScript library
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem 'jbuilder', '~> 2.5' Ben 6/12/2018 Not needed since we are using active record serializers
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# Ben 6/12/2018 Commented this out for now im going to use postgresql
# group :development do
# 	gem 'sqlite3' #Ben 6/12/2018 Already declared this at the top
# end

# group :development, :test do
#   # Call 'byebug' anywhere in the code to stop execution and get a debugger console
# 	gem 'byebug', platform: :mri
# end  Ben 6/12/2018 Commented out duplicate group

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'awesome_print', require: 'ap'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
	gem "rspec-rails", "~> 3.7", require: false
	gem "email_spec"
	gem 'shoulda-matchers'
end

group :development, :test do
	gem "factory_bot_rails" #Ben 6/12/2018 factory girl rails is deprecated  added factory bot rails to resolve
	gem 'ffaker'
	gem 'byebug', platform: :mri
end
	
# 11/28/2019 - placing outside of :development, :test block so that it also runs on production
gem 'dotenv-rails' #Ben 6/12/2018 Lets you use environment variables in a .env file where you can store api keys instead of hardcoding them in the project

# group :test do
# 	gem 'shoulda-matchers'
#     #gem 'shoulda', "~> 3.5.0"
# 	gem 'test-unit', '~> 3.2'
# end Ben 6/12/2018 duplicate test group also test unit not needed sine you are using rspec

#Api gems
gem 'active_model_serializers', '~> 0.10.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "devise"
gem 'oauth2', github: 'oauth-xx/oauth2'
gem 'omniauth-oauth2', '~> 1.5.0'
gem 'omniauth-facebook', '~> 5.0.0'
gem 'omniauth-google-oauth2'
gem 'devise-jwt', '~> 0.5.7'#Ben 6/12/2018 Will use this to generate tokens
gem 'simple_command' #Ben 6/12/2018 Makes life easier since this is a service object will use to authorize api requests
#gem 'sabisu_rails', github: "jvrsgsty/sabisu-rails"
gem 'compass-rails', '~> 3.0.2'
#gem 'furatto', github: 'IcaliaLabs/furatto-rails'
gem 'font-awesome-rails'
gem 'simple_form'
# gem 'railties' Ben 6/12/2018 Not needed since this comes with rails by default
# gem 'rack', "~> 2.0"
gem 'kaminari'
gem 'delayed_job_active_record'

gem 'koala'
#

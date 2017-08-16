source 'https://rubygems.org'

ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'activeadmin', '~> 1.0.0'
gem 'chucksay', '~> 0.0.3'
gem 'coffee-rails', '~> 4.2.0'
gem 'devise', '~> 4.3.0'
gem 'doorkeeper', '~> 4.2.6'
gem 'health-monitor-rails', '~> 7.2.2'
gem 'haikunator', '~> 1.1.0'
gem 'jbuilder', '~> 2.7.0'
gem 'omniauth', '~> 1.6.1'
gem 'omniauth-google-oauth2', '~> 0.5.0'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.9.1'
gem 'rack-cors', '~> 0.4.1'
gem 'rails', '~> 5.1.2'
gem 'rake', '~> 12.0.0'
gem 'redis-rails', '~> 5.0.2'
gem 'rodash', '~> 3.0.0'
gem 'sass-rails', '~> 5.0.6'
gem 'turbolinks', '~> 5.0.1'
gem 'uglifier', '~> 3.2.0'

group :development, :test do
  gem 'dotenv-rails', '~> 2.2.1'
  gem 'pry', '~> 0.10.4'
  gem 'rspec-rails', '~> 3.6.0'
end

group :development do
  gem 'listen', '~> 3.1.5'
  gem 'spring', '~> 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.1'
  gem 'web-console', '~> 3.5.1'
end

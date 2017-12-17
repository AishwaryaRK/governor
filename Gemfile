source 'https://rubygems.org'

ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'activeadmin', '~> 1.0'
gem 'chucksay', '~> 0.0'
gem 'coffee-rails', '~> 4.2'
gem 'devise', '~> 4.3'
gem 'devise_cas_authenticatable', '~> 1.10'
gem 'doorkeeper', '~> 4.2'
gem 'haikunator', '~> 1.1'
gem 'health-monitor-rails', '~> 7.2'
gem 'jbuilder', '~> 2.7'
gem 'nokogiri', '~> 1.8'
gem 'omniauth', '~> 1.6'
gem 'omniauth-google-oauth2', '~> 0.5'
gem 'pg', '~> 0.21'
gem 'puma', '~> 3.9'
gem 'rack-cors', '~> 0.4'
gem 'rails', '~> 5.1'
gem 'rake', '~> 12.0.0'
gem 'redis-rails', '~> 5.0'
gem 'redis-store', '~> 1.4'
gem 'rodash', '~> 3.0.0'
gem 'ruby-saml', '~> 1.4'
gem 'saml_idp', '~> 0.7'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5.0'
gem 'uglifier', '~> 3.2'

group :development, :test do
  gem 'dotenv-rails', '~> 2.2'
  gem 'pry', '~> 0.10'
  gem 'rspec-rails', '~> 3.6'
end

group :development do
  gem 'listen', '~> 3.1'
  gem 'spring', '~> 2.0'
  gem 'spring-watcher-listen', '~> 2.0'
  gem 'web-console', '~> 3.5'
end

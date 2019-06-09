source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'listen', '~> 3.1.5' # Required by Rails
gem 'bcrypt', '~> 3.1', '>= 3.1.12'

group :development, :test do
  gem 'dotenv-rails', groups: [:development, :test]
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

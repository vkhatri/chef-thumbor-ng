source 'https://rubygems.org'

gem 'rake'
gem 'berkshelf'
gem 'chefspec'
gem 'foodcritic', '~> 3.0'
gem 'rubocop',    '~> 0.24'

group :integration do
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'kitchen-docker'
end

group :test do
  gem 'coveralls', require: false
end

group :development do
  gem 'chef'
  gem 'knife-spork', '~> 1.0.17'
  gem 'knife-spec'
end

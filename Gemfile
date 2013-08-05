source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'pg'
gem 'puma'

gem 'acts_as_votable',
    git: 'git://github.com/supherman/acts_as_votable.git',
    branch: 'sti-voter'

gem 'paperclip', git: 'git://github.com/thoughtbot/paperclip.git', branch: 'rails-4'
gem 'warden', '~> 1.2.1'
gem 'omniauth-github'
gem 'omniauth-twitter'
gem 'jquery-rails'
gem 'turbolinks'
gem 'strong_parameters'

group :assets do
  gem 'sass-rails', '~> 4.0.0'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'bourbon'
  gem 'uglifier', '>= 1.3.0'
end

group :development do
  gem 'pry-rails'
  gem 'better_errors'
end

group :test, :development do
  gem 'minitest-rails'
  gem 'minitest-focus'
  gem 'minitest-colorize'
  gem 'minitest-capybara', '= 0.1.0'
  gem 'minitest-rails-capybara'
  gem 'launchy'
end

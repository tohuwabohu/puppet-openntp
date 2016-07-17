source ENV['GEM_SOURCE'] || 'https://rubygems.org'

group :development, :test do
  gem 'metadata-json-lint', '~> 0.0.11'
  gem 'rake', '~> 11.2'
  gem 'rspec', '~> 3.5'
  gem 'rspec-puppet', '~> 2.4'
  gem 'puppetlabs_spec_helper', '~> 1.1'
  gem 'puppet-blacksmith', '~> 3.4'
  gem 'puppet-lint', '~> 2.0'
  gem 'puppet-syntax', '~> 2.1'

  gem 'rest-client', '~> 1.8'  # Ruby 1.9.2 compatible
end

group :system_tests do
  gem 'beaker', '~> 2.47'
  gem 'beaker-rspec', '~> 5.6'
  gem 'serverspec', '~> 2.31'
end

if puppetversion = ENV['PUPPET_VERSION']
  gem 'puppet', puppetversion
else
  gem 'puppet', '~> 4.5'
end

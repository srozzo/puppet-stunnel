# Install via
# bundle install --path vendor/gems
#
if ENV.key?('PUPPET_VERSION')
    puppetversion = "= #{ENV['PUPPET_VERSION']}"
  else
    puppetversion = ['>= 2.7']
end

source :rubygems
gem 'mocha',        '>= 1.1.0'
gem 'puppet',       '>= 3.0.0'
gem 'facter',       '>= 2.4.3'
gem 'puppet-lint'
gem 'rspec-puppet', ">= 2.1.0"
gem 'rake',         '>= 0.9.6'
gem 'puppetlabs_spec_helper', '0.10.2'

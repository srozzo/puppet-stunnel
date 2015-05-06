# spec/classes/init_spec.rb
require 'spec_helper'

describe "stunnel", :type => :class do

  let(:facts) { {concat_basedir: '/var/lib/puppet/concat'} }
  let(:params) {
    {
      'global_options' => {
        'cert' => '/etc/stunnel/keys/global.pem'
      },
      'tunnels' => {
        'smtp' => {
          'options' => {
            'accept' => '2525',
            'client' => 'yes',
            'connect' => 'email-smtp.us-west-2.amazonaws.com:465',
            'delay'   => 'yes'
          }
        }
      }
    }
  }

  it { is_expected.to contain_stunnel }
  it { is_expected.to contain_stunnel__params }

  context 'The catalog should at the very least compile' do
    it { should compile }
  end

  context 'It should instantiate all and contain all relevant classes' do
    it { should create_class('stunnel::install') }
    it { should create_class('stunnel::config') }
    it { should create_class('stunnel::service') }
  end
end

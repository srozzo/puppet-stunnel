# spec/classes/init_spec.rb
require 'spec_helper'

describe "stunnel::config", :type => :class do

  let(:facts) { {concat_basedir: '/var/lib/puppet/concat'} }

  let(:params) {
    {
      'global_options' => {
        'cert' => '/etc/stunnel/keys/global.pem'
      },
      'service_conf' => '/etc/stunnel/stunnel.conf',
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

end

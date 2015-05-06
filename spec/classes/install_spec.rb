# spec/classes/init_spec.rb
require 'spec_helper'

describe "stunnel::install" do

  let(:params) {
    {
      :package_ensure => 'present',
      :package_name => 'stunnel'
    }
  }

  it { should contain_package('stunnel').with(
      'ensure' => 'present',
      'name' => 'stunnel'
    )
  }
end

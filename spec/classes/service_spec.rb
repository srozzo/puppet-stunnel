require 'spec_helper'

describe "stunnel::service", :type => :class do

  let(:params) {
    {
      'service_ensure' => 'running',
      'service_name' => 'stunnel'
    }
  }

  it do
    should contain_service('stunnel').with(
      'ensure'      => 'running',
      'name'        => 'stunnel',
      'hasstatus'   => 'false',
      'hasrestart'  => 'true'
    )
  end

end

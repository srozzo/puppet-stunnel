require 'spec_helper'

describe "stunnel::params", :type => :class do

  it "Should not contain any resources" do
    should have_resource_count(0)
  end

end

require File.dirname(__FILE__) + '/../spec_helper'

describe Table do
  before(:each) do
    @table = Table.new
  end

  it "should be valid" do
    @table.should be_valid
  end
end

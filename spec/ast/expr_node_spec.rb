require 'spec_helper'

describe ExprNode do
  describe "constants" do

	it "sets INVALID constant" do
	  ExprNode::INVALID.should == 0
	end
  	it "sets VECTOR constant" do
	  ExprNode::VECTOR.should == 2
	end
  	it "sets INTEGER constant" do
	  ExprNode::INTEGER.should == 1
	end
  end
end

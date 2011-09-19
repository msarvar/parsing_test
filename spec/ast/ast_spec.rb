require 'spec_helper'

describe Ast do
  describe "#initialize" do
  	context "argument is token" do
	  it "sets the token" do
	  	@ast = Ast.new(Token.new(1))
	  	@ast.token.class.should == Token
	  end
	end

	context "argument is token" do
	  it "sets the token" do
		@ast = Ast.new(1)
		@ast.token.class.should == Token
	  end
	end
  end
end

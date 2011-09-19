require 'spec_helper'

describe AddNode do
  let(:plus) { Token.new(CommonLexer::PLUS, "+") }
  let(:expr_one) { ExprNode.new(Token.new(CommonLexer::INT, "1")) }
  let(:expr_two) { ExprNode.new(Token.new(CommonLexer::INT, "2")) }
  let(:expr_one_list) { ExprNode.new(Token.new(CommonLexer::VEC, "VEC")) }
  let(:expr_two_list) { ExprNode.new(Token.new(CommonLexer::VEC, "VEC")) }

  describe "#initialize" do
    it "adds children to the node" do
      @add_node = AddNode.new(expr_one, plus, expr_two)
      @add_node.children.size.should == 2
      @add_node.children.all?{|c| c.class == ExprNode}.should be_true
    end
  end
  describe "#eval_type" do
  	context "left and right nodes are INTEGER" do
  	  it "returns INTEGER" do
	  	@add_node = AddNode.new(expr_one, plus, expr_two)
  	  	@add_node.eval_type.should == ExprNode::INTEGER
	  end
	end
	context "left and right nodes are VECTOR" do
	  it "returns VECTOR" do
		@add_node = AddNode.new(expr_one_list, plus, expr_two_list)
  	  	@add_node.eval_type.should == ExprNode::VECTOR
	  end
	end
	context "left and right nodes are different types" do
  	  it "returns INVALID" do
	  end
	end
  end
end

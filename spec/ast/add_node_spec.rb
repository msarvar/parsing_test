require 'spec_helper'

describe AddNode do
  let(:plus) { Token.new(CommonLexer::PLUS, "+") }
  let(:expr_one) { ExprNode.new(Token.new(CommonLexer::INT, "1")) }
  let(:expr_two) { ExprNode.new(Token.new(CommonLexer::INT, "2")) }

  describe "#initialize" do
    it "adds children to the node" do
      @add_node = AddNode.new(expr_one, plus, expr_two)
      @add_node.left.should == expr_one
      @add_node.right.should == expr_two
    end
  end

  describe "#eval_type" do
    context "left and right nodes are INTEGER" do
      it "returns INTEGER" do
        one = mock
        stub(one).eval_type {ExprNode::INTEGER}
        two = mock
        stub(two).eval_type {ExprNode::INTEGER}
        @add_node = AddNode.new(one, plus, two)
        @add_node.eval_type.should == ExprNode::INTEGER
      end
    end

    context "left and right nodes are VECTOR" do
      it "returns VECTOR" do
        one = mock
        stub(one).eval_type {ExprNode::VECTOR}
        two = mock
        stub(two).eval_type {ExprNode::VECTOR}
        @add_node = AddNode.new(one, plus, two)
        @add_node.eval_type.should == ExprNode::VECTOR
      end
    end

    context "left and right nodes are different types" do
      it "returns INVALID" do
        one = mock
        stub(one).eval_type {ExprNode::INVALID}
        two = mock
        stub(two).eval_type {ExprNode::INVALID}
        @add_node = AddNode.new(one, plus, two)
        @add_node.eval_type.should == ExprNode::INVALID

      end
    end
  end
end

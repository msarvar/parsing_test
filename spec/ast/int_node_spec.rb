require 'spec_helper'

describe IntNode do
  describe "#initialize" do
    it "sets eval_type to INTEGER" do
      one = Token.new(CommonLexer::INT, "1")
      int_node = IntNode.new(one)
      int_node.eval_type.should == ExprNode::INTEGER
    end
  end
end

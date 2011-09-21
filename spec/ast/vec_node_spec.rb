require 'spec_helper'

describe VecNode do
  describe "#initialize" do
    it "sets eval_type to VECTOR" do
      vec = Token.new(CommonLexer::VEC)
      vec_node = VecNode.new(vec, [])
      vec_node.eval_type.should == ExprNode::VECTOR
    end

    it "sets children elements of the vector" do
      one = IntNode.new(Token.new(CommonLexer::INT, "1"))
      two = IntNode.new(Token.new(CommonLexer::INT, "2"))
      three = IntNode.new(Token.new(CommonLexer::INT, "3"))
      list = [one, two, three]
      vector = VecNode.new(Token.new(CommonLexer::VEC), list)
      vector.elements.should == list
    end
  end
end

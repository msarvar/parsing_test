require 'spec_helper'

describe PrintVisitor do
  let(:print_visitor) { PrintVisitor.new }
  describe "#print" do
    context "AddNode" do
      it "visits the left and right velues of the node and prints out '+' in between" do
        one = IntNode.new(Token.new(CommonLexer::INT, "1"))
        two = IntNode.new(Token.new(CommonLexer::INT, "2"))
        @node = AddNode.new(one, Token.new(CommonLexer::PLUS, "+"), two)
        mock(@node.left).visit(print_visitor)
        mock(@node.right).visit(print_visitor)
        mock($stdout).puts("+")
        @node.visit(print_visitor)
      end
    end

    context "IntNode" do
      it "prints the node's value" do
        one = IntNode.new(Token.new(CommonLexer::INT, "1"))
        mock($stdout).puts("1")
        one.visit(print_visitor)
      end
    end

    context "VecNode" do
      it "prints '[' and visits each elements of the vector and closes it with ']'" do
        one = IntNode.new(Token.new(CommonLexer::INT, "1"))
        two = IntNode.new(Token.new(CommonLexer::INT, "2"))
        list = [one, two]
        vector = VecNode.new(Token.new(CommonLexer::VEC), list)
        mock($stdout).puts('[')
        mock(vector).elements { [] }
        mock($stdout).puts(']')
        vector.visit(print_visitor)
      end
    end
  end
end

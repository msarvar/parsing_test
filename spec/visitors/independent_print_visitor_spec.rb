require 'spec_helper'

describe IndPrintVisitor do
  let(:ind_print_visitor) {IndPrintVisitor.new}
  describe "#print" do
    it "prints out vector elements and covers it with '[', ']'" do
      one = IntNode.new(Token.new(CommonLexer::INT, "1"))
      two = IntNode.new(Token.new(CommonLexer::INT, "2"))
      three = IntNode.new(Token.new(CommonLexer::INT, "3"))
      list = [one, two, three]
      vector = VecNode.new(Token.new(CommonLexer::VEC), list)
      mock($stdout).puts("[")
      mock(vector).elements {[]}
      mock($stdout).puts("]")
      ind_print_visitor.print(vector)
    end
  end
end

require 'spec_helper'

describe "Parser" do
  before do
    @lexer = CommonLexer.new("[a,b=d,c]")
    @parser = Parser.new(@lexer)
    @parser.pointer.should == 0
    @parser.lookahead.size.should == 1
  end

  describe "#initialize" do
    it "sets input to a commonlexer obj" do
      @parser.input.should == @lexer
    end

    it "sets pointer to 0" do
      @parser.pointer.should == 0
    end

    it "fill lookahead with tokens" do
      @parser.lookahead.size.should == 1
      @parser.lookahead.first.type.should == CommonLexer::LBRACK
      @parser.lookahead.first.text.should == '['
    end
  end

  describe "#consume" do
    it "sets next token as a lookahead" do
      @parser.consume
      @parser.lookahead[@parser.pointer].type.should == CommonLexer::NAME
    end

    it "increments the pointer by one when pointer value is not equal to the size of lookahead" do
      mock(@parser.lookahead).size { 2 }
      mock(@parser).sync(1) { true }
      pointer = @parser.pointer + 1
      @parser.consume
      @parser.pointer.should == pointer
    end

    it "increments the pointer by one when speculating" do
      mock(@parser).speculating? { true }
      pointer = @parser.pointer + 1
      @parser.consume
      @parser.pointer.should == pointer
    end

    it "sets pointer to 0 if the size of lookahead the same as the pointers value" do
      @parser.lookahead.size == 1
      @parser.consume
      @parser.pointer.should == 0
    end
  end

  describe "#match" do
    it "point to a next token if the pattern match" do
      @parser.match(CommonLexer::LBRACK)
      @parser.lookahead[@parser.pointer].type.should == CommonLexer::NAME
    end

    it "raises an error if pattern does not match" do
      lambda { @parser.match(CommonLexer::NAME) }.should raise_error(ArgumentError)
    end
  end

  describe "#sync" do
    it "syncronizes lookahead to a current pointer" do
      mock(@parser.lookahead).size { 0 }
      mock(@parser).fill(1)
      @parser.sync(1)
    end

    it "doesn't syncronizes lookahead if the current pointer is lower then lookahead" do
      mock(@parser.lookahead).size { 2 }
      dont_allow(@parser).fill(1)
      @parser.sync(1)
    end
  end

  describe "#fill" do
    it "fills lookahead with n tokens" do
      @parser.fill(2)
      @parser.lookahead.size == 2
    end
  end

  describe "#mark" do
    it "marks the current entry point" do
      pointer = @parser.pointer
      @parser.mark.should == pointer
      @parser.markers.pop.should == pointer
    end
  end

  describe "#release" do
    it "returns a last pointer from the markers hash" do
      @parser.markers = [0]
      mock(@parser).seek(0) { 0 }
      @parser.release.should == 0
    end
  end

  describe "#seek" do
    it "sets the pointer to a given index" do
      @parser.pointer.should == 0
      @parser.seek(10)
      @parser.pointer.should == 10
    end
  end

  describe "#speculating?" do
    it "returns true if current stream is a speculative alternative" do
      @parser.markers = [0]
      @parser.speculating?.should be_true
    end

    it "returns false if current stream is not a speculative alternative" do
      @parser.markers = []
      @parser.speculating?.should be_false
    end
  end
end

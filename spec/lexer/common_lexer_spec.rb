require 'spec_helper'

describe CommonLexer do
  before { @lexer = CommonLexer.new("asd") }
  describe "constants" do
    it "has iall necessary constants" do
      CommonLexer::NAME.should == 2
      CommonLexer::COMMA.should == 3
      CommonLexer::LBRACK.should == 4
      CommonLexer::RBRACK.should == 5
      CommonLexer::EQUALS.should == 6
    end

    it "has TOKEN_NAMES constant with token names in it" do
      CommonLexer::TOKEN_NAMES.should == ["n/a", "<EOF>", "NAME", "COMMA", "LBRACK", "RBRACK", "EQUALS", "INTEGER", "PLUS"]
    end
  end

  describe "#get_token_names" do
    it "returns NAME token" do
      @lexer.get_token_name(CommonLexer::NAME).should == CommonLexer::TOKEN_NAMES[CommonLexer::NAME]
    end
  end

  describe "#is_letter?" do
    it "returns true if a char is a letter" do
      @lexer.is_letter?.should be_true
    end

    it "returns false if a char is not a letter" do
      @lexer.char = "1"
      @lexer.is_letter?.should be_false
    end

  end

  describe "#next_token" do
    it "returns a next token on the stack" do
      @lexer = CommonLexer.new("[a, b, c]")
      @lexer.next_token.should be_an_instance_of Token
    end

    it "skips a whitespace" do
      @lexer = CommonLexer.new("[a, b, c]")
      @lexer.pointer = 3
      @lexer.char = ' '
      expect { @lexer.next_token }.to change(@lexer, :pointer).from(3).to(5)
    end

    it "creates a string from a flow of letters" do
      @lexer = CommonLexer.new("abcd")
      token = @lexer.next_token
      token.text.should == "abcd"
      token.type.should == CommonLexer::NAME
    end

    it "return <EOF> on end of file" do
      @lexer = CommonLexer.new("a")
      @lexer.next_token
      token = @lexer.next_token
      token.text.should == "<EOF>"
      token.type.should == CommonLexer::EOF_TYPE
    end
  end
end

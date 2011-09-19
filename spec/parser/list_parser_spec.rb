require 'spec_helper'

describe ListParser do
  before do
    @lexer1 = CommonLexer.new("[a,b,c] = [z, c]")
    @parser1 = ListParser.new(@lexer1)
    @lexer2 = CommonLexer.new("[a,b,c]")
    @parser2 = ListParser.new(@lexer2)
  end

  describe "#stat" do
    it "parses a list if speculate_stat_alt1 is true" do
      mock(@parser2).list
      mock(@parser2).speculate_stat('list') { @parser2.list }.returns(true)
      dont_allow(@parser2).assign
      mock(@parser2).match(CommonLexer::EOF_TYPE)
      @parser2.stat
    end

    it "parses an assignment if speculate_stat_alt2 is true" do
      mock(@parser1).assign
      mock(@parser1).speculate_stat('assign') { @parser1.assign }.returns(true)
      mock(@parser1).speculate_stat('list') { @parser1.list }.returns(false)
      mock(@parser1).match(CommonLexer::EOF_TYPE)
      @parser1.stat
    end
  end

  describe "speculate_stat" do
    it "speculates a parsing rule and return true if the given rule matches the input" do
      stub(@parser2).mark
      stub(@parser2).list
	  stub(@parser2).match
      stub(@parser2).release
      (@parser2.speculate_stat('list') { @parser2.list }).should be_true
    end

    it "speculates a parsing rule and return false if the given rule doesn't match the input" do
      stub(@parser2).mark
      stub(@parser2).list { raise ArgumentError }
      stub(@parser2).release
      (@parser2.speculate_stat('list') { @parser2.list }).should be_false
    end
  end

  describe "#elements" do
    it "parses the elements of the list" do
    end
  end

  describe "#list" do
    it "parses a list when an input is valid" do
    end

    it "raises an ArgumentError if input is incorrect list" do
    end
  end

end

require 'spec_helper'
describe "Token" do
  before { @token = Token.new(CommonLexer::NAME, ']') }

  describe "#initialize" do
    it "sets token type and text" do
      @token.text.should == ']'
      @token.type.should == CommonLexer::NAME
    end
  end

  describe "#to_s" do
    it "return string value of the token" do
      @token.to_s.should == %{<'#{@token.text}', #{CommonLexer::TOKEN_NAMES[@token.type]}>}
    end
  end
end

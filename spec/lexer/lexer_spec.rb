require 'spec_helper'

describe Lexer do
  before { @lexer = Lexer.new("a= [x = 1, 2, 3]") }
  it "sets EOF and EOF_TYPE consts" do
    Lexer::EOF.should == "-1"
    Lexer::EOF_TYPE.should == 1
  end

  describe "initialize" do

    it "sets pointer, input and char accessors" do
      @lexer.pointer.should == 0
      @lexer.input.should == "a= [x = 1, 2, 3]"
      @lexer.char.should == @lexer.input[@lexer.pointer]
    end
  end

  describe "#consume" do
    it "increments the pointer by one in order to move to the next element" do
      expect { @lexer.consume }.to change(@lexer, :pointer).by(1)
    end

    it "set EOF if pointer is equal or bigger then the size of the input" do
      @lexer.pointer = @lexer.input.size
      @lexer.consume
      @lexer.char.should == Lexer::EOF
    end

    it "sets next element as a char accessor" do
      @lexer.consume
      @lexer.char.should == @lexer.input[@lexer.pointer]
    end

  end

  describe "#match" do
    it "consumes the element when char variable matches it" do
      expect { @lexer.match(@lexer.input[@lexer.pointer]) }.to change(@lexer, :pointer).by(1)
    end

    it "throws an exeption if char does not match it" do
      lambda { @lexer.match(@lexer.input[@lexer.pointer + 1]) }.should raise_error ArgumentError
    end
  end
end

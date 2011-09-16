class Lexer
  EOF = "-1"
  EOF_TYPE = 1

  attr_accessor :input, :pointer, :char

  def initialize(input)
  	@pointer = 0
  	@input = input
  	@char = input[pointer]
  end

  def consume
  	@pointer += 1
	if pointer >= input.size
	  @char = EOF
	else
	  @char = input[pointer]
	end
  end

  def match(matcher)
  	if char == matcher
  	  consume
  	else
  	  raise ArgumentError, "expecting #{matcher}; found #{char}"
	end
  end
end

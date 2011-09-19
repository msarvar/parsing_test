class CommonLexer < Lexer
  NAME = 2
  COMMA = 3
  LBRACK = 4
  RBRACK = 5
  EQUALS = 6
  INT = 7
  PLUS = 8
  VEC = 9

  TOKEN_NAMES = %w{n/a <EOF> NAME COMMA LBRACK RBRACK EQUALS INTEGER PLUS VEC}

  def initialize(input)
  	super(input)
  end

  def get_token_name(index)
  	TOKEN_NAMES[index]
  end

  def is_letter?
  	char >= 'a' && char <= 'z' || char >= 'A' && char <= 'Z'
  end

  def next_token
  	while char != EOF do
  	  case char
	  when ' ', '\t', '\n', '\r'
	  	white_space; next
  	  when ','
  	  	consume; return Token.new(COMMA, ',')
	  when '['
		consume; return Token.new(LBRACK, '[')
	  when ']'
	  	consume; return Token.new(RBRACK, ']')
	  when '='
	  	consume; return Token.new(EQUALS, '=')
	  else
	  	return name if is_letter?
	  	raise ArgumentError, "invalid character: #{char}"
  	  end
	end
	Token.new(EOF_TYPE, "<EOF>")
 end

 def name
  	buffer = ""
  	begin
  	  buffer << char
  	  consume
	end while is_letter?
	Token.new(NAME, buffer)
  end

  def white_space
  	while( char == ' ' || char == '\t' || char == '\n' || char == '\r') do
  	  consume
  	end
  end
end

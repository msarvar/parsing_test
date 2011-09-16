class ListParser < Parser
  def initialize(input)
  	super(input)
  end

  def stat
  	if speculate_stat('list') { list }
  	  list
  	  match(Lexer::EOF_TYPE)
	elsif speculate_stat('assign') { assign }
	  puts "predicts alternative 2"
	  assign
  	  match(Lexer::EOF_TYPE)
    else
  	  raise SyntaxError, "expecting stat found #{lt(1)}"
	end
  end

  def speculate_stat(alt, &func)
  	success = true
  	puts "Attempt alternative #{alt}"
  	mark
	begin
	  func.call
	  match(Lexer::EOF_TYPE)
	rescue
	  success = false
	end
	release
	success
  end

  def list
  	failed = false
  	start_token_index = pointer
  	return if speculating? && already_parsed?
  	begin
  	  _list
	rescue
	  failed = true
	  raise ArgumentError
	ensure
	  memoize(start_token_index, failed) if speculating?
	end
  end

  def _assign
  	failed = false
	start_token_index = pointer
	return if speculating? && already_parsed?
	begin
	  _assign
	rescue
	  failed = true
	  raise ArgumentError
	ensure
	  memoize(start_token_index, failed) if speculating?
	end
  end

  def assign
  	list
  	match(CommonLexer::EQUALS)
  	list
  end

  def _list
  	puts "parse list rule at token index: #{pointer}"
  	match(CommonLexer::LBRACK)
  	elements
  	match(CommonLexer::RBRACK)
  end

  def elements
  	element
  	while lt(1).type == CommonLexer::COMMA
  	  match(CommonLexer::COMMA)
  	  element
	end
  end

  def element
  	if la(1) == CommonLexer::NAME && la(2) == CommonLexer::EQUALS
	  match(CommonLexer::NAME)
	  match(CommonLexer::EQUALS)
	  match(CommonLexer::NAME)
	elsif la(1) == CommonLexer::NAME
	  match(CommonLexer::NAME)
	elsif la(1) == CommonLexer::LBRACK
	  list
	else
	  raise ArgumentError, "expecting name or listl found #{lookahead}"
	end
  end
end

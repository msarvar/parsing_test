class Token
  attr_accessor :text, :type
  def initialize(type, text)
  	@text = text
  	@type = type
  end

  def to_s
  	%{<'#{text}', #{CommonLexer::TOKEN_NAMES[type]}>}
  end
end

class Ast
  attr_accessor :token, :children

  def initialize(token)
  	if token.is_a?(Token)
  	  @token = token
	elsif token.is_a?(Integer)
	  @token = Token.new(token)
	end
  end

  def node_type
  	token.type
  end

  def add_child(t)
	@children ||= []
	@children << t
  end

  def nil?
  	token.nil?
  end

  def to_s
  	token.nil? ? "nil" : token.to_s
  end

  def to_s_tree
  	return self.to_s if children == nil || children.empty?
  	buf = ""
  	buf << "(#{self.to_s} " unless nil?

	children.each_with_index do |child, index|
	  buf << " " if index > 0
	  buf << child.to_s_tree
	end

	buf << ")" unless nil?
	buf
  end
end

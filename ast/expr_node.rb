class ExprNode < Ast
  attr_accessor :eval_type

  INVALID = 0
  INTEGER = 1
  VECTOR  = 2
  def initialize(payload)
  	super(payload)
  end

  def to_s
  	#if eval_type != INVALID
  	#  return super.to_s + "<type=#{eval_type == INTEGER ? "INTEGER" : "VECTOR"}>"
	#end

	super.to_s
  end
end

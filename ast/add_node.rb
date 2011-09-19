class AddNode < ExprNode
  def initialize(left, add_token, right)
  	super(add_token)
  	add_child(left)
  	add_child(right)
  end

  def eval_type
  	if left.eval_type == INTEGER && right.eval_type == INTEGER
  	INTEGER
  end
end

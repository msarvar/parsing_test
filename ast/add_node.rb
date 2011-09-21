class AddNode < ExprNode
  attr_accessor :left, :right
  def initialize(left, add_token, right)
    super(add_token)
    @left = left
    @right = right
  end

  def eval_type
    if left.eval_type == INTEGER && right.eval_type == INTEGER
      INTEGER
    elsif left.eval_type == VECTOR && right.eval_type == VECTOR
      VECTOR
    else
      INVALID
    end
  end
end

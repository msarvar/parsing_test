class IntNode < ExprNode
  def initialize(t)
    super(t)
    @eval_type = INTEGER
  end
end

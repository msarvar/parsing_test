class VecNode < ExprNode
  attr_accessor :elements

  def initialize(t, elements)
    super(t)
    @eval_type = VECTOR
    @elements = elements
  end

end

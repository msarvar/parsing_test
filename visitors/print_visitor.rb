class PrintVisitor
  def visit(node)
    case node.class.to_s
    when AddNode.to_s
      node.left.visit(self)
      puts "+"
      node.right.visit(self)
    when IntNode.to_s
      puts node.to_s
    when VecNode.to_s
      puts '['
      node.elements.each{|e| e.visit(self)}
      puts ']'
    end
  end
end

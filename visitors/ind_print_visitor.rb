class IndPrintVisitor
  def print(node)
    case node.class.to_s
    when IntNode.to_s
      puts node.to_s
    when VecNode.to_s
      puts "["
      node.elements.each {|e| print(e)}
      puts "]"
    end
  end
end

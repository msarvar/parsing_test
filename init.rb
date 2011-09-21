WATT_ROOT = File.absolute_path('')
$LOAD_PATH.unshift(WATT_ROOT)
require 'ast/ast'
require 'ast/expr_node'
require 'ast/add_node'
require 'ast/int_node'
require 'ast/vec_node'
require 'visitors/print_visitor'
require 'visitors/ind_print_visitor'
Dir[WATT_ROOT + ("/lexer/*.rb")].reverse.each {|f| require f}
Dir[WATT_ROOT + ("/parser/*.rb")].reverse.each {|f| require f}
Dir[WATT_ROOT + ("/*.rb")].reverse.each {|f| require f}

one = IntNode.new(Token.new(CommonLexer::INT, "1"))
two = IntNode.new(Token.new(CommonLexer::INT, "2"))
three = IntNode.new(Token.new(CommonLexer::INT, "3"))
list = [one, two, three]
vector = VecNode.new(Token.new(CommonLexer::VEC), list)
vector.visit(PrintVisitor.new)

IndPrintVisitor.new.print(vector)

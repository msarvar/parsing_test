WATT_ROOT = File.absolute_path('')
$LOAD_PATH.unshift(WATT_ROOT)
require 'ast/ast'
require 'ast/expr_node'
require 'ast/add_node'
Dir[WATT_ROOT + ("/lexer/*.rb")].reverse.each {|f| require f}
Dir[WATT_ROOT + ("/parser/*.rb")].reverse.each {|f| require f}
Dir[WATT_ROOT + ("/*.rb")].reverse.each {|f| require f}

plus = Token.new(CommonLexer::PLUS, "+")
one = Token.new(CommonLexer::INT, "1")
two = Token.new(CommonLexer::INT, "2")

root = Ast.new(plus)
root.add_child(Ast.new(one))
root.add_child(Ast.new(two))

puts root.to_s_tree

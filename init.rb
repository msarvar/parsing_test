WATT_ROOT = File.absolute_path('')
$LOAD_PATH.unshift(WATT_ROOT)
Dir[WATT_ROOT + ("/lexer/*.rb")].reverse.each {|f| require f}
Dir[WATT_ROOT + ("/parser/*.rb")].reverse.each {|f| require f}
Dir[WATT_ROOT + ("/*.rb")].reverse.each {|f| require f}

lexer = CommonLexer.new("[a,b]=[z,d]")
parser = ListParser.new(lexer)
parser.stat # begin parsing at rule stat

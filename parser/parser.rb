class Parser
  FAILED = -1
  attr_accessor :input, :lookahead, :pointer, :markers, :memoization
  def initialize(input)
  	@input = input
  	@lookahead = []
  	@markers = []
  	@pointer = 0
  	@memoization = {}
  	sync(1)
  end

  def consume
  	@pointer += 1
  	if pointer == lookahead.size && !speculating?
  	  @pointer = 0
	  @lookahead = []
	  @memoization = {}
	end
	sync(1)
  end

  def lt(i)
  	sync(i)
  	lookahead[pointer + i - 1]
  end

  def la(i)
	lt(i).type
  end

  def match(type)
   if la(1) == type
   	 consume
   else
   	 raise ArgumentError, "expecting #{input.get_token_name(type)}; found #{lt(1)}"
   end
  end

  def sync(i)
    look_size = lookahead.size
  	if pointer + i > look_size
  	  n = pointer + i - look_size
  	  fill(n)
	end
  end

  def fill(n)
  	(1..n).each {|i| @lookahead << input.next_token }
  end

  def mark
  	@markers << pointer
  	pointer
  end

  def release
  	marker = markers.pop
  	seek(marker)
  end

  def seek(index)
  	@pointer = index
  end

  def speculating?
  	markers.size > 0
  end

  def already_parsed?
	memo = memoization[pointer]
	return false if memo.nil?
	puts "parsed list before at index #{pointer}; skip to token index #{memo}: #{lookahead[memo].text}"
	raise ArgumentError if memo == FAILED
	seek(memo)
	true
  end

  def memoize(start_token_index, failed)
  	stop_token_index = failed ? FAILED : pointer
  	@memoization[start_token_index] = stop_token_index
  end
end

#You can only use arrays to do stack and queue. And You can only Use forward indexes: I.e. [1, 2 etc] but not [-1, -3 etc.]
#Can only use the length method.
#can use simple loops like loop. while. times, for, but not each, map etc.

class Stack 
	
	def initialize()
		@array = []
	end

	def push(item)
		length = @array.length
		@array[length] = item
	end

	def pop
		length = @array.length
		temp = @array[length]
		@array[length] = nil
		return temp
	end

	def peek
		length = @array.length
		return @array[length - 1]
	end

	def empty?
		if @array.length == 0
			return true
		else
			return @array
		end
	end
end

a = Stack.new()
string = "Stringtobereversed"
x = string.length
for i in 1..x 
	a.push(string[x - i])
end

puts a.empty?

	

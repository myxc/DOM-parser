require_relative 'node'
require_relative 'parser'

class Searcher
	attr_accessor :tree

	def initialize(tree)
		@tree = tree
	end

	def search(key, value, node = @tree)
		results = []
		node_queue = [] #bfs
		current = node

		loop do 
			break if current.nil?
			
			if key == :classes
				break if current.classes.nil?
		       results << current if current.classes.include?(value)
		    elsif key == :name
				break if current.name.nil?
		    	results << current if current.name.include?(value)
		    elsif key == :id
				break if current.id.nil?
		    	results << current if current.id.include?(value)
		    elsif key == :text
				break if current.text.nil?
		    	results << current if current.id.include?(value)
		    else
		    	puts "Wrong parameter. Search failed."
		    	break
		    end

		    current.children.each do |child|
		    	node_queue << child
		    end if !current.children.nil?

		    current = node_queue.shift
		end
		results
	end

	def desc_search(node, key, value)
		search(key, value, node)
	end

	def asc_search(node, key, value)
		results = []
		current = node

		loop do
			current = current.parent
			break if current.nil?

			if key == :classes
				break if current.classes.nil?
		       results << current if current.classes.include?(value)
		    elsif key == :name
				break if current.name.nil?
		    	results << current if current.name.include?(value)
		    elsif key == :id
				break if current.id.nil?
		    	results << current if current.id.include?(value)
		    elsif key == :text
				break if current.text.nil?
		    	results << current if current.id.include?(value)
		    else
		    	puts "Wrong parameter. Search failed."
		    	break
		    end
		end
		results
	end
end
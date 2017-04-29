require_relative 'parser'

class Renderer
	attr_accessor :node_i, :tree

	def initialize(tree)
		@tree = tree
		@node_i = {}
	end

	def render(node)
		@node_i = {}
		node = @tree if node.nil?
		num_nodes = subtree_size(node)

		puts "NODE
    name: #{node[0]} | text: #{node[1]} | class: #{node[2]} | id: #{node[3]}
    Number of nodes in the sub-tree of this node is #{num_nodes}
    Child | Count"
		@node_i.each do |name, count|
			if count < 10
				puts "#{name} | 0#{count}".rjust(13)
			else
				puts "#{name} | #{count}".rjust(13)
			end
		end
	end

	def subtree_size(node)
		num_nodes = 0
		return num_nodes if node.children.empty?

		node.children.each do |child|
			if @node_i[child.name].nil?
				@node_i[child.name] = 1
			else
				@node_i[child.name] += 1
			end
			num_nodes += 1 + subtree_size(child)
		end

		num_nodes
	end
end


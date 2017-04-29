TagNode = Struct.new(:tag, :contents, :class, :id, :parent, :children)

class TagTree
	#Tree of tags, nested tags will just be nodes that are children of the tags that they're nested inside of.
	#To reconstruct the tree, it will just read in a dfs fashion.
	
	#contents will be in an ordered array and will just iterate from beginning through to the end of it, each time it encounters a node as an lement, it enters that node and then continues.
	#if it enters a new node, current node gets pushed to the top of the stack so that you know where to go to come back to it afterwards.
	def initialize
		@root = TagNode.new()
		@totalNodes = 1 #total nodes lets you know how many nodes are in the tree.
	end

	def readContents(string)
		#if the line contains a marker then it creates a new node and enters it, simultaneously pushing the previous node onto the stack so you know where to go back to, and also changing parent/children specifiers for the two nodes
		#if the line contains an identifier then it will change the type of the corresponding identifying in the struct for the current node.
		#if a line contains a marker than shows it is completed, then it will be popped from the stack
		#nodes will be created/treated in a stack fashion so most recent (the child) and children will all finish before the outermost ones.

	end

	def nodeRenderer(tree)
		#to find the number of nodes beneath a certain node is simple, just sum up the nodes in children, as well as their children etc. using a dfs style search
		#to count the number of nodes of each type, just go through the progeny of the node, storing attribute of each into an array, and then outputting the unique attribute names as well as how many times they appeared.
	end

	def treeSearcher(tree)
		#gives it a tree to search through
		#calls several methods based on what search is called 
		search_by(:class, "sidebar")
		search_children(some_node, :id, "ksks")
		search_ancestors(some_node, :id, "asdas")
	end

	def search_by(sub_tag, string)

	end

	def search_children(node, sub_tag, string)
	end

	def search_ancestors(node, sub_tag, string)
	end
end


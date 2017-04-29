require_relative 'node.rb'
require_relative 'tree_methods.rb'
require_relative 'parser.rb'

parser = Parser.new
tree = parser.build_tree("practice_html.html")
print "This tree has #{parser.num_nodes} nodes\n\n"

#test search
searcher = Searcher.new(tree)
lists = searcher.search(:name, "div")
renderer = Renderer.new(tree)
lists.each { |node| renderer.render(node) }
Node = Struct.new(:name, :text, :classes, :id, :children, :parent)

class Parser
	attr_accessor :root, :num_nodes, :html
	
	def initialize
	end

	def build_tree(file)
		@html = File.open(file).readlines.map do |line|
			line.strip #remove whitespace at start/end
		end

		@root = Node.new("file", nil, nil, nil, [], nil)
		@num_nodes = 1
		create_tree
		@root
	end

	def parse_string(line)
		html_hash = {} #store info to hash because enumeration is based on order of key insertion
		#regex: ? makes it lazy, () means capture group, \w+ means one or more word chars, . means any char other than line break, * means zero or more times
		#capture all tags:
		tags_regex = /<(\w+)?>/
		#capture all attributes
		attr_regex = /(\w+)=/
		#captures the corresponding values of attributes
		attr_values_regex = /="(.*?)"/
		#captures text in between tags
		text_regex = />(.*?)</

		#strip arrays made by scanning for tags, text, attributes and attr values
		tags = line.scan(tags_regex).map do |tag|
			tag[0]
		end
		
		attributes = line.scan(attr_regex).map do |attr|
	      attr[0]
	    end
	    
	    values = line.scan(attr_values_regex).map do |value|
	      value[0]
	    end
	    text = line.scan(text_regex).map do |text|
	      text[0]
	    end

	    #store to the hash for each corresponding key
	    html_hash["tag"] = tags[0]
	    html_hash.merge!(Hash[attributes.zip(values)]) #contents of hash created by zipping attributes and attr_values arrays togetherh then merging with duplicate keys being overwritten.
	    html_hash["class"] = html_hash["class"].split if !html_hash["class"].nil? #
	    html_hash["text"] = text.join

	    html_hash
	end

	def create_tree #makes the tree using html code
		current_node = root
		@html.each do |line|
			next if line.include?("filetype") #avoids line of html that doesn't say anything

			if line[0..1] == "</" #check if this is the end of a tag
				current_node = current_node.parent
			elsif line[0] == "<" #this is a tag
				tag = parse_string(line)
				node = Node.new(tag["tag"], tag["text"], tag["class"], tag["id"], [], current_node)
				current_node.children << node
				current_node = node
				@num_nodes += 1
				current_node = current_node.parent if line.end_with?("</#{current_node.name}>")
			elsif line != nil
				current_node.text += line
			end
		end
	end				

	def node_to_html(node) #to turn each entry into a line of piece of html when converting back
		if node.id.nil?
			name = node.name
			id = ""
			classes = ""
		else
			id = "id=#{node.id}"
			classes = "class='#{node.class}'"
		end

		html = "<#{name}#{classes}#{id}>\n#{text}\n"
	end

	def convert_from_tree(root)
		return "empty" if node.nil?

		current_node = root
		html_str = node_to_html(current_node)
		current_node.children.each do |child|
			html_str += convert_from_tree(child) + "</#{child.name}>\n"
		end

		html_str
	end

end

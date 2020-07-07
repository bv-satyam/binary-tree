node = './node.rb'
utility = './utility.rb'

require node if File.file? node
require utility if File.file? utility


class BinaryTree
	attr_reader :root

	def initialize(data)
		# Initialize the tree with data as root.
		@root = Node.new(data)
	end

	def add(data)
    _add(@root, data)
	end
	
	def find_max
		_find_max(@root)
	end

	def find_min
		_find_min(@root)
	end

	def inorder_traversal(head)
		_inorder_traversal(head)
	end

	def preorder_traversal(head)
    return _preorder_traversal(head)
	end

	def postorder_traversal(head)
		return _postorder_traversal(head)
	end

	def level_traversal(head)
		_level_traversal(head)
	end

	def search(head, query)
		return _search(head, query)
	end

	def delete(head, query)
		return _delete(head, query)
	end

	def print_all_paths
		_print_all_paths(@root, [], 0)
  end
end


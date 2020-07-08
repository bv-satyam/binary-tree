
class Node
	attr_accessor :left, :right, :data

	def initialize(data)
		@data = data
	end
end


class BinaryTree
	attr_reader :root

	def initialize(data)
		# Initialize the tree with data as root.
		@root = Node.new(data)
	end

	def add(data)
		# Add an element (data) to the tree.
		q = [@root]
		while q.size > 0
			current_node = q[0]
			q.shift(1)
			if !current_node.left
				current_node.left = Node.new(data)
				break
			else
				q.push(current_node.left)
			end

			if !current_node.right
				current_node.right = Node.new(data)
				break
			else
				q.push(current_node.right)
			end
		end
	end
	
	def find_max(head)
		if !head
			return -Float::INFINITY
		end
    value = head.data
    left = find_max(head.left)  
    right = find_max(head.right)  
    if left > value
      value = left
    end
    if right > value
      value = right
    end
    return value
	end

	def find_min(head)
		if !head
			return Float::INFINITY
		end
    value = head.data
    left = find_min(head.left)  
    right = find_min(head.right)  
    if left < value
      value = left
    end
    if right < value
      value = right
    end
    return value
	end

	def inorder_traversal(head)
		if !head.nil?
			inorder_traversal(head.left)
			puts head.data
			inorder_traversal(head.right)
		end
	end

	def preorder_traversal(head)
		return [] if !head
    return [head.data] + preorder_traversal(head.left) + preorder_traversal(head.right)
	end

	def postorder_traversal(head)
		if !head.nil?
			postorder_traversal(head.left)
			postorder_traversal(head.right)
			puts head.data
		end
	end

	def level_traversal(head)
		q = [head]
		q.push("-----")
		while q.size > 0
			current_node = q[0]
			q.shift(1)
			if current_node == "-----"
				puts current_node
				if q.size > 0
					q.push(current_node)
				end
				next
			end
			puts current_node.data
			q.push(current_node.left) if current_node.left
			q.push(current_node.right) if current_node.right
		end
	end

	def search(head, query)
		if !head
			return false
		elsif head.data == query || search(head.left, query) || search(head.right, query)
			return true
		else
			return false
		end
	end

	def _delete_deepest(head, query)
    q = [] 
    q.append(head)
    while q.size > 0
      temp = q[0]
      q.shift(1)
      if temp == query
        temp = nil
        return
      end	
      if temp.right
        if temp.right == query
          temp.right = nil
          return
        else
            q.append(temp.right)
        end
      end
      if temp.left
        if temp.left == query
          temp.left = nil
          return
        else
          q.append(temp.left)
        end
      end
    end
  end

	def delete(head, query)
		if !head
			return nil
		elsif !head.left && !head.right
			if head.data == query
				return nil
			else
				return head
			end
		end
		key_node = nil
	    q = []
	    q.append(head)
	    while q.size > 0
        temp = q[0]
        q.shift(1)
        if temp.data == query 
          key_node = temp
          break
        end 
        if temp.left 
          q.append(temp.left)
        end 
        if temp.right 
          q.append(temp.right)
        end 
	    end
	    if key_node
				x = temp.data 
        _delete_deepest(head, temp)
        key_node.data = x
       end
	    return head
	end

	def print_all_paths(head, path, path_len)
		if !head 
      return
    elsif path.size > path_len
      path[path_len] = head.data 
    else
      path.append(head.data)
  	end
    path_len = path_len + 1
  
    if !head.left && !head.right 
    	print head.data, ": "
      print path[0, path_len], "\n"
    else
      print_all_paths(head.left, path, path_len)
      print_all_paths(head.right, path, path_len)
		end
	end

end


btree = nil


while true
  puts "Choose an input option: \n
   1. Add elements to the tree
   2. Print largest element
   3. Print smallest element
   4. Print Inorder Traversal
   5. Print Preorder Traversal
   6. Print Postorder Traversal
   7. Print Level Order Traversal
   8. Search an element by value
   9. Remove an element by value
   10. Print all Root to Leaf paths
   Enter 'quit' To exit"

  input_option = STDIN.gets.chomp
  puts "Input provided: #{input_option}"
  puts "Output:"
  case input_option
  when "quit"
    puts "Saving End state of Binary Tree (Pre-order Traversal)"
    begin
      output_file = File.new("output.txt", "w")
      output_file.print(p btree.preorder_traversal(btree.root))
    	puts "End state of Binary Tree (Pre-order Traversal) saved in output.txt"
    rescue
      puts "Error in writing file"
    ensure
      output_file.close if output_file
    end
    puts "Exiting..."
    break
    
  when "1"
    puts "Enter element to add to the tree:"
    new_input = STDIN.gets.chomp
    new_input = new_input.split(",")
    new_input.each { |str| abort "Invalid Input" unless str.to_i.to_s == str }
    new_input = new_input.map { |curr_value| curr_value.to_i }
    new_input.each {
      |curr_value|
      if curr_value
        if btree
        	btree.add(curr_value)
    		else
    			btree = BinaryTree.new(curr_value)
    		end
      end
    }
  when "2"
    puts btree.find_max(btree.root)
  when "3"
    puts btree.find_min(btree.root)
  when "4"
    p btree.inorder_traversal(btree.root)
  when "5"
    p btree.preorder_traversal(btree.root)
  when "6"
    p btree.postorder_traversal(btree.root)
  when "7"
  	p btree.level_traversal(btree.root)
    
  when "8"
  	puts "Enter a value to find:"
    new_input = STDIN.gets.chomp
    new_input = new_input.split(",")
    if new_input[0].to_i
    	if btree.search(btree.root, new_input[0].to_i)
      	puts "Element found."
    	else
    		puts "Element Not Present."
  		end
    else
      puts "Invalid Input"
    end
    
  when "9"
  	puts "Enter a value to remove:"
    new_input = STDIN.gets.chomp
    new_input = new_input.split(",")
    if new_input[0].to_i
    	btree.delete(btree.root, new_input[0].to_i)
      puts " Removed #{new_input[0].to_i}."
    else
      puts "Invalid Input"
    end

  when "10"
    btree.print_all_paths(btree.root, [], 0)
  else
    puts "Invalid Input"
  end
  puts "\n\n\n"
end

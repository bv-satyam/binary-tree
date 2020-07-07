node = './node.rb'
require node if File.file? node


def _add(root, data)
	# Add an element (data) to the tree.
	q = [root]
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

def _find_max(head)
	if !head
		return -Float::INFINITY
	end
  value = head.data
  left = _find_max(head.left)  
  right = _find_max(head.right)  
  if left > value
    value = left
  end
  if right > value
    value = right
  end
  return value
end

def _find_min(head)
	if !head
		return Float::INFINITY
	end
  value = head.data
  left = _find_min(head.left)  
  right = _find_min(head.right)  
  if left < value
    value = left
  end
  if right < value
    value = right
  end
  return value
end

def _inorder_traversal(head)
	if !head.nil?
		_inorder_traversal(head.left)
		puts head.data
		_inorder_traversal(head.right)
	end
end

def _preorder_traversal(head)
	return [] if !head
  return [head.data] + _preorder_traversal(head.left) + _preorder_traversal(head.right)
end

def _postorder_traversal(head)
	if !head.nil?
		_postorder_traversal(head.left)
		_postorder_traversal(head.right)
		puts head.data
	end
end

def _level_traversal(head)
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

def _search(head, query)
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

def _delete(head, query)
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

def _print_all_paths(head, path, path_len)
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
    _print_all_paths(head.left, path, path_len)
    _print_all_paths(head.right, path, path_len)
	end
end
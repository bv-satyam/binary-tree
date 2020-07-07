constants_file = './constants.rb'
require constants_file if File.file? constants_file

class UI
  def initialize()
    @btree = nil
  end

  def show_options
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
  end

  def run
    while true
      show_options

      input_option = STDIN.gets.chomp
      puts "Input provided: #{input_option}"
      puts "Output:"
      case input_option
      when QUIT
        quit
        break
      when ADD
        add
      when LARGEST_ELEMENT
        puts @btree.find_max
      when SMALLEST_ELEMENT
        puts @btree.find_min
      when INORDER_Traversal
        p @btree.inorder_traversal(@btree.root)
      when PREORDER_Traversal
        p @btree.preorder_traversal(@btree.root)
      when POSTORDER_Traversal
        p @btree.postorder_traversal(@btree.root)
      when LEVEL_ORDER_Traversal
        p @btree.level_traversal(@btree.root)
      when SEARCH
        search
      when DELETE
        delete
      when ROOT_TO_LEAF_PATHS
        @btree.print_all_paths
      else
        puts "Invalid Input"
      end
      puts "\n\n\n"
    end
  end

  def quit
    puts "Saving End state of Binary Tree (Pre-order Traversal)"
    begin
      output_file = File.new("output.txt", "w")
      output_file.print(p @btree.preorder_traversal(@btree.root))
      puts "End state of Binary Tree (Pre-order Traversal) saved in output.txt"
    rescue
      puts "Error in writing file"
    ensure
      output_file.close if output_file
    end
    puts "Exiting..."
  end

  def add
    puts "Enter element to add to the tree:"
    new_input = STDIN.gets.chomp
    new_input = new_input.split(",")
    new_input.each { |str| abort "Invalid Input" unless str.to_i.to_s == str }
    new_input = new_input.map { |curr_value| curr_value.to_i }
    new_input.each {
      |curr_value|
      if curr_value
        if @btree
          @btree.add(curr_value)
        else
          @btree = BinaryTree.new(curr_value)
        end
      end
    }
  end

  def search
    puts "Enter a value to find:"
    new_input = STDIN.gets.chomp
    new_input = new_input.split(",")
    if new_input[0].to_i
      if @btree.search(@btree.root, new_input[0].to_i)
        puts "Element found."
      else
        puts "Element Not Present."
      end
    else
      puts "Invalid Input"
    end
  end 

  def delete
    puts "Enter a value to remove:"
    new_input = STDIN.gets.chomp
    new_input = new_input.split(",")
    if new_input[0].to_i
      @btree.delete(@btree.root, new_input[0].to_i)
      puts " Removed #{new_input[0].to_i}."
    else
      puts "Invalid Input"
    end
  end

end


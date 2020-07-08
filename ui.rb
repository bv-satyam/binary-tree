class UI
  def initialize()
    @btree = nil
  end

  module CHOICES
    ADD_ELEMENT = "1"
    LARGEST_ELEMENT = "2"
    SMALLEST_ELEMENT = "3"
    INORDER_TRAVERSAL = "4"
    PREORDER_TRAVERSAL = "5"
    POSTORDER_TRAVERSAL = "6"
    LEVEL_ORDER_TRAVERSAL = "7"
    SEARCH = "8"
    DELETE = "9"
    ROOT_TO_LEAF_PATHS = "10"
    QUIT = "quit"
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
      when CHOICES::QUIT
        quit
        break
      when CHOICES::ADD_ELEMENT
        add
      when CHOICES::LARGEST_ELEMENT
        puts @btree.find_max(@btree.root)
      when CHOICES::SMALLEST_ELEMENT
        puts @btree.find_min(@btree.root)
      when CHOICES::INORDER_TRAVERSAL
        p @btree.inorder_traversal(@btree.root)
      when CHOICES::PREORDER_TRAVERSAL
        p @btree.preorder_traversal(@btree.root)
      when CHOICES::POSTORDER_TRAVERSAL
        p @btree.postorder_traversal(@btree.root)
      when CHOICES::LEVEL_ORDER_TRAVERSAL
        p @btree.level_traversal(@btree.root)
      when CHOICES::SEARCH
        search
      when CHOICES::DELETE
        delete
      when CHOICES::ROOT_TO_LEAF_PATHS
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


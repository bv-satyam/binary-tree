ui_file = './ui.rb'
binary_tree_file = './binary-tree.rb'

require ui_file if File.file? ui_file
require binary_tree_file if File.file? binary_tree_file


ui = UI.new
ui.run
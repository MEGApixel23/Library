ROOT = Dir.pwd

require 'json'
require ROOT + '/classes/Storage.rb'
require ROOT + '/classes/Author.rb'
require ROOT + '/classes/Book.rb'
require ROOT + '/classes/Reader.rb'
require ROOT + '/classes/Order.rb'
require ROOT + '/classes/Library.rb'
=begin
author = Author.new({'author' => 'Author', 'bio' => 'Bio'})
author.save

book = Book.new({'title' => 'Title', 'author' => author})
book.save

reader = Reader.new({'name' => 'Name'})
reader.save

order = Order.new({'book' => book, 'reader' => reader})
order.save

puts order.inspect
=end
library = Library.get_by_id 3
library.who_often_takes_book 1
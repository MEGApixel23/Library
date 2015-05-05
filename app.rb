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
=end

=begin
order = Order.get_by_id 1
author = Author.get_by_id 1
book = Book.get_by_id 1
reader = Reader.get_by_id 1

library = Library.new
library << order
library << author
library << book
library << reader

library.save
=end

library = Library.get_by_id 2
library << (Order.get_by_id 2)
library.save
print library.who_often_takes_book 3
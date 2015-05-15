require_relative "Library/version"

ROOT = Dir.pwd

require 'json'
require_relative "Library/classes/Storage"
require_relative "Library/classes/Author"
require_relative "Library/classes/Book"
require_relative "Library/classes/Reader"
require_relative "Library/classes/Order"
require_relative "Library/classes/Library"

=begin
author = Library::Author.new({'author' => 'Author', 'bio' => 'Bio'})
author.save
book = Library::Book.new({'title' => 'Title', 'author' => author})
book.save
reader = Library::Reader.new({'name' => 'Name'})
reader.save
order = Library::Order.new({'book' => book, 'reader' => reader})
order.save
=end

=begin
order = Library::Order.get_by_id 1
author = Library::Author.get_by_id 1
book = Library::Book.get_by_id 1
reader = Library::Reader.get_by_id 1

library = Library::Library.new
library << order
library << author
library << book
library << reader

library.save
=end

=begin
library = Library::Library.get_by_id 2
library << (Library::Order.get_by_id 2)
library.save
print library.who_often_takes_book 3
print library.most_popular_book
=end

=begin
library = Library::Library.get_by_id 2
print library.who_often_takes_book 3
=end

=begin
library = Library::Library.get_by_id 2
print library.most_popular_books_readers
=end
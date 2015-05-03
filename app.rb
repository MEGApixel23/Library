ROOT = Dir.pwd

require 'json'
require ROOT + '/classes/Storage.rb'
require ROOT + '/classes/Author.rb'
require ROOT + '/classes/Book.rb'

author = Author.get_by_id 2
book = Book.get_by_id 1
book.author = author

puts book.author
book.save

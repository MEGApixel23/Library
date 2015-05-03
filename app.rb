ROOT = Dir.pwd

require 'json'
require ROOT + '/classes/Storage.rb'
require ROOT + '/classes/Author.rb'
require ROOT + '/classes/Book.rb'
require ROOT + '/classes/Reader.rb'
require ROOT + '/classes/Order.rb'

reader = Reader.get_by_id 1
book = Book.get_by_id 1

order = Order.new({'book' => book, 'reader' => reader})
order.save

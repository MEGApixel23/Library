class Library < Storage
  attr_reader :books, :orders, :readers, :authors

  def initialize
    @books, @orders, @readers, @authors = {}
  end

  def <<(obj)
    if (obj.instance_of? Book)
      @books[obj.id] = obj
    end
  end
end
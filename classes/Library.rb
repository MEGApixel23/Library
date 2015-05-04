class Library < Storage
  attr_reader :books, :orders, :readers, :authors

  def initialize(data = {})
    @books, @orders, @readers, @authors =
        data['books'] || {}, data['orders'] || {}, data['readers'] || {},
            data['authors'] || {}
    @id = data['id'] || new_id
  end

  def <<(obj)
    if (obj.instance_of? Book)
      @books[obj.id] = obj
    elsif (obj.instance_of? Order)
      @orders[obj.id] = obj
    elsif (obj.instance_of? Reader)
      @readers[obj.id] = obj
    elsif (obj.instance_of? Author)
      @authors[obj.id] = obj
    end

    self
  end

  def self.path_to_storage
    return ROOT + '/storage/libraries'
  end

  def save
    result = {}
    self.instance_variables.each do |var|
      hash = self.instance_variable_get var
      var = var.to_s.gsub('@', '')

      result[var] = []

      if hash.instance_of? Hash
        hash.each do |key, val|
          result[var].push key
        end
      end
    end

    result['id'] = @id

    file = File.new(self.class.path_to_storage + "/#{@id}.txt", 'w')
    file.write result.to_json

    self
  end

  def self.get_by_id id
    dump = File.read path_to_storage + "/#{id}.txt"
    data = JSON.load dump

    result = {}

    if data.instance_of? Hash
      data.each do |key, val|
        result[key] = {}

        if (val.instance_of? Array)
          val.each do |id|
            if (key === 'books')
              result[key][id] = Book.get_by_id id
            elsif (key === 'authors')
              result[key][id] = Author.get_by_id id
            elsif (key === 'orders')
              result[key][id] = Order.get_by_id id
            elsif (key === 'readers')
              result[key][id] = Reader.get_by_id id
            end
          end
        end
      end
    end

    self.new result
  end

  def who_often_takes_book(book)
    result = {}
    @orders.each do |key, val|
      result[val.reader.id] = 1
    end
  end
end
class Order < Storage
  def initialize(data = {})
    @book, @reader, @date = data['book'] || '', data['reader'] || '',
        data['date'] || ''
    @id = data['id'] || new_id

    puts @reader.id
  end

  def self.path_to_storage
    return ROOT + '/storage/orders'
  end

  def book
    if @book.class == Book
      @book
    else
      Book.get_by_id @book
    end
  end

  def reader
    puts @reader
    if @reader.class == Reader
      @reader
    else
      Reader.get_by_id @reader
    end
  end

  def save
    hash = {}
    self.instance_variables.each do |var|
      value = self.instance_variable_get var
      var = var.to_s.gsub('@', '')

      if value.class == Book || value.class == Reader
        value = value.id
      end

      hash[var] = value
    end

    file = File.new(self.class.path_to_storage + "/#{@id}.txt", 'w')
    file.write hash.to_json

    self
  end
end
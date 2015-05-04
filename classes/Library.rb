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
            result[key][id] = Book.get_by_id id
          end
        end
      end
    end

    puts result

    self.new data
  end
end
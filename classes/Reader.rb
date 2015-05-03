class Reader < Storage
  attr_reader :id

  def initialize(data = {})
    @name, @email, @city, @street, @house = data['name'] || '', data['email'] || '',
        data['city'] || '', data['street'] || '', data['house'] || ''
    @id = data['id'] || new_id
  end

  def self.path_to_storage
    return ROOT + '/storage/readers'
  end

  def save
    hash = {}
    self.instance_variables.each do |var|
      value = self.instance_variable_get var
      var = var.to_s.gsub('@', '')
      hash[var] = value
    end

    file = File.new(self.class.path_to_storage + "/#{@id}.txt", 'w')
    file.write hash.to_json

    self
  end
end
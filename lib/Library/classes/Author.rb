module Library
  class Author < Storage
    attr_reader :id
    attr_accessor :name, :bio

    def initialize(data = {})
      @name, @bio, @id = data['name'] || '', data['bio'] || '', data['id'] || new_id
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

    def self.path_to_storage
      return ROOT + '/Library/storage/authors'
    end
  end
end
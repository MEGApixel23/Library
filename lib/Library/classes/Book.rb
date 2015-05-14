module Library
  class Book < Storage
    attr_reader :id

    def initialize(data = {})
      @author, @title, @id =
          data['author'] || '', data['title'] || '', data['id'] || new_id
    end

    def self.path_to_storage
      return ROOT + '/Library/storage/books'
    end

    def author
      if @author.class == Author
        @author
      else
        Author.get_by_id @author
      end
    end

    def author=(author)
      @author = author
    end

    def save
      hash = {}
      self.instance_variables.each do |var|
        value = self.instance_variable_get var
        var = var.to_s.gsub('@', '')

        if value.class == Author
          value = value.id
        end

        hash[var] = value
      end

      file = File.new(self.class.path_to_storage + "/#{@id}.txt", 'w')
      file.write hash.to_json

      self
    end
  end
end
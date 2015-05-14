module Library
  class Storage
    def new_id
      last_id = 0

      Dir.chdir(self.class.path_to_storage)
      Dir.glob('[0-9]{1,}.txt').each do |x|
        id = Integer( x.match(/([0-9]{1,})/).to_s )
        last_id = id if id > last_id
      end

      last_id + 1
    end

    def self.get_by_id id
      dump = File.read path_to_storage + "/#{id}.txt"
      data = JSON.load dump

      self.new data
    end
  end
end
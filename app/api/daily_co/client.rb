module DailyCo
  class Client
    def self.get_rooms
      response = Request.get_delete('get', "/rooms")
    end

    def self.create_room
      response = Request.post('post', "/rooms")
    end

    def self.get_room(name)
      response = Request.get_delete('get', "/rooms/#{name}")
    end

    def self.update_room(name)
      response = Request.post('post', "/rooms/#{name}")
    end

    def self.delete_room(name)
      response = Request.get_delete('delete', "/rooms/#{name}")
    end
  end
end
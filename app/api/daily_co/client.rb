module DailyCo
  class Client
    def self.get_rooms
      response = Request.get_delete('get', "/rooms")
    end

    def self.create_room
      payload = {
        "name" => "getting-started-webinar",
        "privacy" => "private",
        "properties" => {
          "start_audio_off" => true,
          "start_video_off" => true
        }
      }
      response = Request.post('post', "/rooms", payload)
    end

    def self.get_room(name)
      response = Request.get_delete('get', "/rooms/#{name}")
    end

    def self.update_room(name)
      payload = {
        "privacy" => "public"
      }
      response = Request.post('post', "/rooms/#{name}", payload)
    end

    def self.delete_room(name)
      response = Request.get_delete('delete', "/rooms/#{name}")
    end
  end
end
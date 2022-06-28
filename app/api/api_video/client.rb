module ApiVideo
  class Client
    def self.auth
      response = Request.auth('post', "/auth/api-key")
    end

    def self.get_videos
      response = Request.get('get', "/videos?currentPage=1&pageSize=25")
    end

    def self.create(auth, title)
      response = Request.create('post', "/videos", auth, title)
    end

    def self.upload(auth, video_id, pathname)
      response = Request.upload('post', "/videos/#{video_id}/source", auth, pathname)
    end

    def self.delete(auth, video_id)
      response = Request.delete('delete', "/videos/#{video_id}", auth)
    end
  end
end
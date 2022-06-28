module ApiVideo
  class Client
    def self.auth
      response = Request.auth('post', "/auth/api-key")
    end

    def self.get_videos
      response = Request.get('get', "/videos?currentPage=1&pageSize=25")
    end

    def self.create(title)
      response = Request.create('post', "/videos", title)
    end

    def self.upload(video_id)
      response = Request.upload('post', "/videos/#{video_id}/source")
    end
  end
end
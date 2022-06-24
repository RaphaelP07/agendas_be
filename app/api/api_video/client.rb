module ApiVideo
  class Client
    def self.auth
      response = Request.auth('post', "/auth/api-key")
    end

    def self.get_videos
      response = Request.get('get', "/videos?currentPage=1&pageSize=25")
    end
  end
end
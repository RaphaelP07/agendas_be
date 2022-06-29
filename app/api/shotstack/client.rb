module Shotstack
  class Client
    # def self.templates
    #   response = Request.get_delete('get', "/templates")
    # end

    def self.render_meeting
      body = {
        "timeline": {
          "background": "#000000",
          "tracks": [
            {
              "clips": [
                {
                  "asset": {
                    "type": "video",
                    "src": "https://cdn.api.video/vod/vi1b8xUmCalRTkX9UJd4YqCY/mp4/source.mp4?dl=1"
                  },
                  "start": 0,
                  "opacity": 1,
                  "fit": "contain",
                  "length": 4
                },
                {
                    "asset": {
                      "type": "video",
                      "src": "https://cdn.api.video/vod/vi4rEJ498qSBX44Z2NFd4FlP/mp4/source.mp4?dl=1"
                    },
                    "length": 4,
                    "start": 4
                }
              ]
            }
          ]
        },
        "output": {
          "format": "mp4",
          "resolution": "sd"
        }
      }
      response = Request.render_meeting('get', "/render", body)
    end
  end
end
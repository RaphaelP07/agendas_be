module Shotstack
  class Client
    def self.templates
      response = Request.get_delete('get', "/templates")
    end

    def self.template(id)
      response = Request.get_id('get', "/templates/#{id}")
    end

    def self.create_template(body)
      response = Request.post('post', "/templates", body)
    end

    def self.render_meeting(videos)
      clips_array = videos.map {
        |asset|
        {
          "asset": {
            "type": "video",
            "volume": 1,
            "src": asset[:source_url]
          },
          "start": 0,
          "fit": "contain",
          "length": asset[:duration]
        }
      }

      html_array = videos.map {
        |asset|
        {
          "asset": {
            "type": "html",
            "html": "<h1>#{asset[:name]}</h1>",
            "css": "h1 { font-size: 75px; color: white }",
            "background": "#003972",
            "height": 85,
            "width": 800
          },
          "start": 0,
          "length": asset[:duration],
          "position": "bottom",
          "fit": "none",
          "offset": {
            "y": 0.055
          }

        }
      }
      
      clips = clips_array.each { 
        |asset|
        clips_array.index(asset) == 0 ? asset[:start] = 0 : asset[:start] = clips_array[clips_array.index(asset) - 1][:start] + clips_array[clips_array.index(asset) - 1][:length]
      }

      html = html_array.each { 
        |asset|
        html_array.index(asset) == 0 ? asset[:start] = 0 : asset[:start] = html_array[html_array.index(asset) - 1][:start] + html_array[html_array.index(asset) - 1][:length]
      }
    
      body = {
        "timeline": {
          "background": "#000000",
          "tracks": [
            {
              "clips": html
            },
            {
              "clips": clips
            }
          ]
        },
        "output": {
          "format": "mp4",
          "resolution": "sd"
        }
      }

      response = Request.post('post', "/render", body)
    end

    def self.render_status(id)
      response = Request.get_id('get', "/render/#{id}")
    end
  end
end
module ApiVideo
  class Request
    TOKEN = ENV["API_VIDEO_KEY"]
    BASE_URL = 'https://sandbox.api.video'

    def self.auth(http_method, endpoint)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}",
        headers: {
          'Accept': 'application/json', 
          'Content-Type': 'application/json'
        },
        payload: {"apiKey": TOKEN}.to_json
      )
      { code: result.code, status: 'Success', data: JSON.parse(result.body)}
    rescue RestClient::ExceptionWithResponse => error
      { code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
    end

    def self.get(http_method, endpoint)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}",
        headers: {
          'Accept': 'application/json', 
          'Authorization': "Basic RE5QYklDVlhGcm1VZVBWUDJiMmNYTFN3c1JLRjFNTjc2Vmp3ejRjWW5WQTo"
        }
      )
      { code: result.code, status: 'Success', data: JSON.parse(result.body)}
    rescue RestClient::ExceptionWithResponse => error
      { code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
    end
    
    def self.create(http_method, endpoint, title)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}",
        headers: {
          'Accept': 'application/json', 
          'Content-Type': 'application/json',
          'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NTY0MTA5NDguMDE2NjksIm5iZiI6MTY1NjQxMDk0OC4wMTY2OSwiZXhwIjoxNjU2NDE0NTQ4LjAxNjY5LCJhcGlLZXlWYWx1ZSI6IkROUGJJQ1ZYRnJtVWVQVlAyYjJjWExTd3NSS0YxTU43NlZqd3o0Y1luVkEifQ.Jd-9Admnatqu8EAX4w9PilKXT58msekykj1Nm8kks0pCdO6UXg4ySjOT-sjZvwSZM21EVrlSwa1X-FtvM7UhddZjV7BoeoBShIA_2nMB5w-YjBNVGHCtTVplY-Bayt0MbMjlX9FAHInCI14JOrB74m8SoMx4Suv026OnT5ioIwn47ZBHuETun1Ct2HD4vxDYRK94xE_6MRbc6Xfq0I-rVi80r_rwM-8TxJVgoNorafAWNHwBsJEc4qKcrUGYeRCP-5RdjLwM_sWMMlw8iydH-xY7_SNpXcDQz6yZDnwFTWVZGp8lof-tk5iWTmyXXqE-cqslgFyJ30egU5OTSwTVdA'
        },
        payload: {"title": title}.to_json
      )
      { code: result.code, status: 'Success', data: JSON.parse(result.body)}
    rescue RestClient::ExceptionWithResponse => error
      { code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
    end

    def self.upload(http_method, endpoint, pathname)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}",
        headers: {
          'Accept': 'application/json', 
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NTY0MTA5NDguMDE2NjksIm5iZiI6MTY1NjQxMDk0OC4wMTY2OSwiZXhwIjoxNjU2NDE0NTQ4LjAxNjY5LCJhcGlLZXlWYWx1ZSI6IkROUGJJQ1ZYRnJtVWVQVlAyYjJjWExTd3NSS0YxTU43NlZqd3o0Y1luVkEifQ.Jd-9Admnatqu8EAX4w9PilKXT58msekykj1Nm8kks0pCdO6UXg4ySjOT-sjZvwSZM21EVrlSwa1X-FtvM7UhddZjV7BoeoBShIA_2nMB5w-YjBNVGHCtTVplY-Bayt0MbMjlX9FAHInCI14JOrB74m8SoMx4Suv026OnT5ioIwn47ZBHuETun1Ct2HD4vxDYRK94xE_6MRbc6Xfq0I-rVi80r_rwM-8TxJVgoNorafAWNHwBsJEc4qKcrUGYeRCP-5RdjLwM_sWMMlw8iydH-xY7_SNpXcDQz6yZDnwFTWVZGp8lof-tk5iWTmyXXqE-cqslgFyJ30egU5OTSwTVdA'
        },
        payload: {file: File.open("/Users/rpadua/Desktop/Movie.mov"), multipart: true }
      )
      { code: result.code, status: 'Success', data: JSON.parse(result.body)}
    rescue RestClient::ExceptionWithResponse => error
      { code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
    end
  end
end
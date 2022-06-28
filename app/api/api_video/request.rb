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

    def self.get_video(http_method, endpoint, auth)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}",
        headers: {
          'Accept': 'application/json', 
          'Content-Type': 'multipart/form-data'
        }
      )
      { code: result.code, status: 'Success', data: JSON.parse(result.body)}
    rescue RestClient::ExceptionWithResponse => error
      { code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
    end
    
    def self.create(http_method, endpoint, auth, title)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}",
        headers: {
          'Accept': 'application/json', 
          'Content-Type': 'application/json',
          'Authorization': "Bearer #{auth}"
        },
        payload: {"title": title}.to_json
      )
      { code: result.code, status: 'Success', data: JSON.parse(result.body)}
    rescue RestClient::ExceptionWithResponse => error
      { code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
    end

    def self.upload(http_method, endpoint, auth, pathname)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}",
        headers: {
          'Accept': 'application/json', 
          'Content-Type': 'multipart/form-data',
          'Authorization': "Bearer #{auth}"
        },
        payload: {file: File.open(pathname), multipart: true }
      )
      { code: result.code, status: 'Success', data: JSON.parse(result.body)}
    rescue RestClient::ExceptionWithResponse => error
      { code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
    end

    def self.delete(http_method, endpoint, auth)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}",
        headers: {
          'Accept': 'application/json', 
          'Content-Type': 'multipart/form-data',
          'Authorization': "Bearer #{auth}"
        }
      )
      { code: result.code, status: 'Success'}
    rescue RestClient::ExceptionWithResponse => error
      { code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
    end
  end
end
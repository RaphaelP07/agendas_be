module DailyCo
  class Request

    TOKEN = ENV["DAILY_CO_KEY"]
    BASE_URL = 'https://api.daily.co/v1'

    def self.get_delete(http_method, endpoint)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}",
        headers: {
          'Content-Type' => 'application/json', 
          'Authorization' => "Bearer #{TOKEN}"
        }
      )
      { code: result.code, status: 'Success', data: JSON.parse(result.body)}
    rescue RestClient::ExceptionWithResponse => error
      { code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
    end

    def self.post(http_method, endpoint, payload)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}",
        headers: {
          'Content-Type' => 'application/json', 
          'Authorization' => "Bearer #{TOKEN}",
        },
        payload: payload.to_json
      )
      { code: result.code, status: 'Success', data: JSON.parse(result.body)}
    rescue RestClient::ExceptionWithResponse => error
      { code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
    end
  end
end
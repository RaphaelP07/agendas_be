module Shotstack
  class Request
    TOKEN = ENV["SHOTSTACK_KEY"]
    BASE_URL = 'https://api.shotstack.io/stage'

    # def self.get_delete(http_method, endpoint)
    #   result = RestClient::Request.execute(
    #     method: http_method,
    #     url: "#{BASE_URL}#{endpoint}",
    #     headers: {
    #       'Accept' => 'application/json',
    #       'x-api-key' => TOKEN
    #     }
    #   )
    #   { code: result.code, status: 'Success', data: JSON.parse(result.body)}
    #   rescue RestClient::ExceptionWithResponse => error
    #   { code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
    # end

    def self.render_meeting(http_method, endpoint, body)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}",
        headers: {
          'Accept': 'application/json',
          'Content_Type': 'application/json',
          'x-api-key': TOKEN
        },
        params: body
      )
      { code: result.code, status: 'Success', data: JSON.parse(result.body)}
      rescue RestClient::ExceptionWithResponse => error
      { code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
    end
  end
end
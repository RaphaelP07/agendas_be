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

    def self.upload(http_method, endpoint)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}",
        headers: {
          'Accept': 'application/json', 
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NTYwNzU1NTEuMTI1MDk1LCJuYmYiOjE2NTYwNzU1NTEuMTI1MDk1LCJleHAiOjE2NTYwNzkxNTEuMTI1MDk1LCJhcGlLZXlWYWx1ZSI6IkROUGJJQ1ZYRnJtVWVQVlAyYjJjWExTd3NSS0YxTU43NlZqd3o0Y1luVkEifQ.dME1Q0HKXt_cCUDwJatan-e490hvXBZ_Kz0aBRWcti0yXfwcRO4fbp0RnVkwI2oRFWSM2UaAd3B4J7MW8Pi9fKem-RffGtZ_CbLURe-0WzeFI5S4_7OyXZNW8L_ZXQVx9za259tB3R_csYpLNNbW1Xw6_jwzBwe9DET2c_QL1kED6hUBf30r2YSDMdDVq-Lv2wTLRCMHoVhh3bEbFbPhPtIgoE0vKzEiTDU1795hEnUIGcVUgqVrpbiBHm9QvCaBmI7V5IKK5Dcsk6Gq1x6fFVSZ_GhG83TmEbYxzJjqjiPM9Tx9VJ0ot0_fHBMglHwyKCr7pds2y0Wbw4ZnD2FSJQ'
        },
        upload: {"file": File.open("/Users/rpadua/Desktop/Movie.mov")}
      )
      { code: result.code, status: 'Success', data: JSON.parse(result.body)}
    rescue RestClient::ExceptionWithResponse => error
      { code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
    end
  end
end
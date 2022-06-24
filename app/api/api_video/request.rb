module Shotstack
  class Request
    TOKEN = ENV["SHOTSTACK_KEY"]
    BASE_URL = 'https://api.shotstack.io/stage'
  end
end
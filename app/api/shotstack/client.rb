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

    def self.render_meeting(body)
      response = Request.post('post', "/render", body)
    end

    def self.render_status(id)
      response = Request.get_id('get', "/render/#{id}")
    end
  end
end
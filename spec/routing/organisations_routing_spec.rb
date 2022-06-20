require "rails_helper"

RSpec.describe Api::V1::OrganisationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "api/v1/organisations").to route_to("organisations#index")
    end

    it "routes to #show" do
      expect(get: "api/v1/organisations/1").to route_to("organisations#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "api/v1/organisations").to route_to("organisations#create")
    end

    it "routes to #update via PUT" do
      expect(put: "api/v1/organisations/1").to route_to("organisations#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "api/v1/organisations/1").to route_to("organisations#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "api/v1/organisations/1").to route_to("organisations#destroy", id: "1")
    end
  end
end

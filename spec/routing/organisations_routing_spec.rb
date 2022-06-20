require "rails_helper"

RSpec.describe Api::V1::OrganisationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "api/v1/organisations").to route_to("api/v1/organisations#index")
    end

    it "routes to #show" do
      expect(get: "api/v1/organisations/1").to route_to("api/v1/organisations#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "api/v1/organisations").to route_to("api/v1/organisations#create")
    end

    it "routes to #update via PUT" do
      expect(put: "api/v1/organisations/1").to route_to("api/v1/organisations#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "api/v1/organisations/1").to route_to("api/v1/organisations#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "api/v1/organisations/1").to route_to("api/v1/organisations#destroy", id: "1")
    end

    it "routes to #join" do
      expect(post: "api/v1/organisations/join").to route_to("api/v1/organisations#join")
    end

    it "routes to #remove_member" do
      expect(delete: "api/v1/organisations/1/remove").to route_to("api/v1/organisations#remove_member", id: "1")
    end

    it "routes to #show_members" do
      expect(get: "api/v1/organisations/1/members").to route_to("api/v1/organisations#show_members", id: "1")
    end
  end
end

require "spec_helper"

describe PlayerAwardsController do
  describe "routing" do

    it "routes to #index" do
      get("/player_awards").should route_to("player_awards#index")
    end

    it "routes to #new" do
      get("/player_awards/new").should route_to("player_awards#new")
    end

    it "routes to #show" do
      get("/player_awards/1").should route_to("player_awards#show", :id => "1")
    end

    it "routes to #edit" do
      get("/player_awards/1/edit").should route_to("player_awards#edit", :id => "1")
    end

    it "routes to #create" do
      post("/player_awards").should route_to("player_awards#create")
    end

    it "routes to #update" do
      put("/player_awards/1").should route_to("player_awards#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/player_awards/1").should route_to("player_awards#destroy", :id => "1")
    end

  end
end

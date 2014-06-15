require "spec_helper"

describe BattingStatsController do
  describe "routing" do

    it "routes to #index" do
      get("/batting_stats").should route_to("batting_stats#index")
    end

    it "routes to #new" do
      get("/batting_stats/new").should route_to("batting_stats#new")
    end

    it "routes to #show" do
      get("/batting_stats/1").should route_to("batting_stats#show", :id => "1")
    end

    it "routes to #edit" do
      get("/batting_stats/1/edit").should route_to("batting_stats#edit", :id => "1")
    end

    it "routes to #create" do
      post("/batting_stats").should route_to("batting_stats#create")
    end

    it "routes to #update" do
      put("/batting_stats/1").should route_to("batting_stats#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/batting_stats/1").should route_to("batting_stats#destroy", :id => "1")
    end

  end
end

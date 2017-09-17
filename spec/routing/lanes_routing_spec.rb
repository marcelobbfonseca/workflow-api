require "rails_helper"

RSpec.describe LanesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/lanes").to route_to("lanes#index")
    end

    it "routes to #new" do
      expect(:get => "/lanes/new").to route_to("lanes#new")
    end

    it "routes to #show" do
      expect(:get => "/lanes/1").to route_to("lanes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/lanes/1/edit").to route_to("lanes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/lanes").to route_to("lanes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/lanes/1").to route_to("lanes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/lanes/1").to route_to("lanes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/lanes/1").to route_to("lanes#destroy", :id => "1")
    end

  end
end

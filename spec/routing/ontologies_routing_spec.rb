require "rails_helper"

RSpec.describe OntologiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ontologies").to route_to("ontologies#index")
    end

    it "routes to #new" do
      expect(:get => "/ontologies/new").to route_to("ontologies#new")
    end

    it "routes to #show" do
      expect(:get => "/ontologies/1").to route_to("ontologies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ontologies/1/edit").to route_to("ontologies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ontologies").to route_to("ontologies#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ontologies/1").to route_to("ontologies#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ontologies/1").to route_to("ontologies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ontologies/1").to route_to("ontologies#destroy", :id => "1")
    end

  end
end

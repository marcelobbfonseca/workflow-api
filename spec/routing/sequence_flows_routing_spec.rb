require "rails_helper"

RSpec.describe SequenceFlowsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sequence_flows").to route_to("sequence_flows#index")
    end

    it "routes to #new" do
      expect(:get => "/sequence_flows/new").to route_to("sequence_flows#new")
    end

    it "routes to #show" do
      expect(:get => "/sequence_flows/1").to route_to("sequence_flows#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sequence_flows/1/edit").to route_to("sequence_flows#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sequence_flows").to route_to("sequence_flows#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sequence_flows/1").to route_to("sequence_flows#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sequence_flows/1").to route_to("sequence_flows#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sequence_flows/1").to route_to("sequence_flows#destroy", :id => "1")
    end

  end
end

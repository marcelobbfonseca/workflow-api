require "rails_helper"

RSpec.describe BusinessProcessesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/business_processes").to route_to("business_processes#index")
    end

    it "routes to #new" do
      expect(:get => "/business_processes/new").to route_to("business_processes#new")
    end

    it "routes to #show" do
      expect(:get => "/business_processes/1").to route_to("business_processes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/business_processes/1/edit").to route_to("business_processes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/business_processes").to route_to("business_processes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/business_processes/1").to route_to("business_processes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/business_processes/1").to route_to("business_processes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/business_processes/1").to route_to("business_processes#destroy", :id => "1")
    end

  end
end

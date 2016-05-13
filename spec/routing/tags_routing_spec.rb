require 'rails_helper'

RSpec.describe TagsController, type: :routing do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/posts/3/tags").to route_to("tags#create", post_id: "3")
    end

    it "routes to #destroy" do
      expect(:delete =>"/posts/3/tags/1").to route_to("tags#destroy", id:"1", post_id: "3")
    end

  end
end

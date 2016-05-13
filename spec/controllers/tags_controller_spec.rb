require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  let!(:user) {FactoryGirl.create(:user)}

  let!(:a_post) do
    Post.create!(
      content: "Look at this a test OMG!",
      user: user
    )
  end

  let!(:valid_attributes) do
    {tag: "tag", post_id: a_post.to_param }
  end

  let(:valid_session) { {} }

  describe "POST #create" do
    it "creates an new tag" do
      expect {
        post :create, {:tag => valid_attributes, post_id: a_post.to_param }, valid_session
      }.to change(Tag, :count).by(1)
    end
  end

end

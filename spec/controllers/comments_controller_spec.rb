require 'rails_helper'


RSpec.describe CommentsController, type: :controller do
  let!(:user) {FactoryGirl.create(:user)}

  let!(:a_post) do
    Post.create!(
      content: "Look at this a test OMG!",
      user: user
    )
  end

  let!(:valid_attributes) do
    {comment: "this is a comment on a post", post_id: a_post.to_param }
  end

  let(:valid_session) { {} }

  describe "POST #create" do
    it "creates an new comment" do
      expect {
        post :create, {:comment => valid_attributes, post_id: a_post.to_param }, valid_session
      }.to change(Comment, :count).by(1)
    end

    it "assigns a newly created comment as @comment" do
      post :create, {:comment => valid_attributes, post_id: a_post.to_param }
      expect(assigns(:comment)).to be_a(Comment)
      expect(assigns(:comment)).to be_persisted
    end

  end


end

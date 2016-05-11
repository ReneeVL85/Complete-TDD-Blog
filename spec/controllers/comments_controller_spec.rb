require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { User.create(email: "user@email.nl", password: "98765432") }

  let!(:a_post) do
    Post.create!(
      content: "Look at this a test OMG!",
      user: user
    )
  end

  let(:valid_attributes) do
    { post_id: a_post.to_param }
  end

  describe "POST #create" do
    it "creates an new comment" do
      expect {
        post :create, {post_id: a_post.to_param}
      }.to change(Comment, :count).by(1)
    end
  end

  describe "DELETE destroy"do
    it "deletes a comment" do
      expect {
        delete :destroy, {post_id: a_post.to_param}
      }.to change(Comment, :count).by(-1)
    end
  end

end

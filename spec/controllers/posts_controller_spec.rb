require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { User.create(email: "user@email.nl", password: "98765432") }

  let(:valid_attributes) do
    {
      content: "Look at this a test OMG!",
      user: user
    }
  end

  let(:invalid_attributes) do
    {
      content: ""
    }
  end

  let!(:a_post) { Post.create! valid_attributes }

    describe "GET #index" do
      it "assigns all posts as @posts" do
        get :index
        expect(assigns(:posts)).to eq([a_post])
      end
    end

    describe "GET #show" do
      it "assigns the requested post as @post" do
        get :show, {id: a_post.to_param}
        expect(assigns(:post)).to eq(a_post)
      end
    end

    describe "POST #create" do
     it "is not accessible when not logged in" do
       post :create, {post: valid_attributes}
       expect(response).to redirect_to new_user_session_path
     end

    context "when logged in" do
      login_user

      context "with valid params" do
       it "creates a new Post" do
         expect {
           post :create, {post: valid_attributes}
         }.to change(Post, :count).by(1)
       end

       it "assigns a newly created post as @post" do
         post :create, {post: valid_attributes}
         expect(assigns(:post)).to be_a(Post)
         expect(assigns(:post)).to be_persisted
       end

       it "assigns the logged in user as the post's creater" do
         post :create, {post: valid_attributes}
         expect(assigns(:post).user).to eq user
       end
     end

     context "with invalid params" do
       it "assigns a newly created but unsaved post as @post" do
         post :create, {post: invalid_attributes}
         expect(assigns(:post)).to be_a_new(Post)
       end

       it "re-renders the 'new' template" do
          post :create, {post: invalid_attributes}
          expect(response).to redirect_to new_post_path
        end
     end
    end
  end

  describe "GET #edit" do
    it "is not accessible when not logged in" do
      get :edit, {id: a_post.to_param}
      expect(response).to redirect_to new_user_session_path
    end

    context "when logged in" do
      login_user

      it " assigns the requested post as @post" do
        get :edit, {id: a_post.to_param}
        expect(assigns(:post)).to eq(a_post)
      end

      it "renders the edit template" do
        get :edit, {id: a_post.to_param}
        expect(response).to render_template("edit")
      end
  end
 end

 describe "PATCH #update" do
   it "is not accessible when not logged in" do
     patch :update, {id: a_post.to_param}
     expect(response).to redirect_to new_user_session_path
   end

   context "when logged in" do
     login_user

     it " allow a post to be updated" do
       expect{ patch :update, id: post.to_param, post: {title: "Lets update title"}.to(
       change{post.reload.title}.to("Lets update title"))}
       expect{ patch :update, id: post.to_param, post: {content: "Lets update content"}.to(
       change{post.reload.content}.to("Lets update content"))}
     end
   end
 end

 describe "DELETE #destroy" do
   let!(:a_post) { Post.create! valid_attributes }
   it "is not accessible when not logged in" do
     delete :destroy, {id: a_post.to_param}
     expect(response).to redirect_to new_user_session_path
   end

   context "when logged in" do
     login_user

     it "allows a post to be deleted" do
       expect {
         delete :destroy, {id: a_post.to_param}
       }.to change(Post, :count).by(-1)
     end
   end

 end

end

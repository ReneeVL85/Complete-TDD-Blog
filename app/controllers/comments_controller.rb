class CommentsController < ApplicationController

  def index
  @comments = Post.all(params[:post_id])
  @comment  = @post.comments.find()
  end


  def create
    @post = Posts.find(params[:post_id])
    @comment = @post.comments.build([:comment])
    @comment.save

    redirect_to @post
  end

  def destroy
  end

end

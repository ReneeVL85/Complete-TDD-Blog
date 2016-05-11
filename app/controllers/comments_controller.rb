class CommentsController < ApplicationController
before_action :set_post, only: [:create, :destroy]

  def create
    @comment = Comment.new
    @comment.post = @post

    if @comment.save
      redirect_to @post, notice: "Thank you for your comment"
    else
      redirect_to @post, alert: "Something went wrong"
    end
  end

  def destroy
  end



  private

  def set_post
    @post = Post.find(params[:post_id])
  end

end

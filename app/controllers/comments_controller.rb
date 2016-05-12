class CommentsController < ApplicationController
before_action :set_post, only: [:create, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post

    respond_to do |format|
      if @comment.save
        format.html {redirect_to [@post, @comment], notice: "Thank you for your comment"}
        format.json {render :show, status: :created, location: [@post, @comment]}
      else
        format.html {render :new, alert: "Something went wrong"}
        format.json {render json: @comment.errors}
      end
   end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    respond_to do |format|
     @comment.destroy
      format.html {redirect_to @post, notice: "Your comment has successfully been deleted"}
      format.json {head :no_content}
    end
  end



  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :id)
  end

end

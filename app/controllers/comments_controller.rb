class CommentsController < ApplicationController

  def create
     post = Post.find( params[:post_id] )

     if comment = Comment.find_by( post: post, user: current_user )
        Comment.destroy
     else
        Comment = Like.new( post: post, user: current_user )
        Comment.save
     end

     redirect_to posts_path
  end

end

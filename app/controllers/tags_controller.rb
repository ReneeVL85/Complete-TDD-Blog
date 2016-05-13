class TagsController < ApplicationController
before_action :set_post, only: [:create, :destroy]

  def create
   tag = Tag.new( tag_params )

    respond_to do |format|
       if tag.save
          format.html {redirect_to posts_path, notice: 'Tag was successfully created.'}
          format.json {render :show, status: :created, location: [@post, @tag]}
       else
         format.html {redirect_to new_post_path, alert: "Something went wrong please try again"}
         format.json {render json: @tag.errors}
       end
     end
  end

  def destroy
    @tag = @post.tag.find(params[:id])

    respond_to do |format|
     @tag.destroy
      format.html {redirect_to @post, notice: "Your comment has successfully been deleted"}
      format.json {head :no_content}
    end
  end


  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def tag_params
     params.require( :tag ).permit( :name, :id )
  end

end

class PostsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @post = Post.new
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
   @post = Post.find( params[:id] )
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      redirect_to new_post_path, alert: "Something went wrong please try again"
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
     @post = Post.find( params[:id] )

     if @post.update_attributes( post_params )
        redirect_to @post
     else
        render 'edit'
     end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
     @post = Post.find( params[:id] )
     @post.user = current_user

     if @post.destroy
       redirect_to posts_path, notice: 'Post was successfully deleted.'
     else
      redirect_to posts_path notice: "Something went wrong please try again"
     end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :id)
    end
end

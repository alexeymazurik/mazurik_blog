class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  add_breadcrumb 'Posts', :posts_path, only: %w(show edit index new)

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
    add_breadcrumb @post.id, post_path
  end

  # GET /posts/new
  def new
    add_breadcrumb 'New post', new_post_path
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    add_breadcrumb 'Edit post', edit_post_path
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter 'white list' through.
    def post_params
      params.require(:post).permit(:title, :text)
    end
end

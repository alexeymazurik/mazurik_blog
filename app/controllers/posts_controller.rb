class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :fetch_sections, only: [:show, :edit, :index, :update, :new, :create]
  before_action :post_owner, only: [:edit, :update, :destroy]
  add_breadcrumb 'Posts', :posts_path, only: %w(show edit index new)

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
    add_breadcrumb @post.id, post_path
    @post.user = User.find(@post.user_id)
  end

  def like
    @post.like(current_user)
    if @post.save
      head :ok, content_type: 'text/html'
    else
      head :error, content_type: 'text/html'
    end
  end

  def unlike
    @post.unlike(current_user)
    if @post.save
      head :ok, content_type: 'text/html'
    else
      head :error, content_type: 'text/html'
    end
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
    @post.user = current_user
    @post.section = @sections.find(params.require(:post)[:section_id])


    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    @post.section = @sections.find(params.require(:post)[:section_id])

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

    def fetch_sections
      @sections = Section.all
    end

    # Only allow a trusted parameter 'white list' through.
    def post_params
      params.require(:post).permit(:title, :text, :annotation, :image_src, tag_list: [])
    end

    def post_owner
      unless @post.user_id == current_user.id
        flash[:notice] = 'Access denied as you are not owner of this job'
        redirect_to posts_path
      end
    end
end

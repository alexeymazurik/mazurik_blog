class PostsController < ApplicationController
  RECOMMENDABLE_METHODS = %w(like unlike dislike undislike).freeze

  before_action :set_post, only: %w(show edit update destroy).concat(RECOMMENDABLE_METHODS)
  before_action :fetch_sections, only: %w(index manage show edit update new create)
  before_action :post_owner, only: %w(edit update destroy)
  respond_to :json, only: RECOMMENDABLE_METHODS

  # GET /posts
  def index
    @q = Post.ransack(params[:q])
    @q.sorts = 'section_id asc' if @q.sorts.empty?
    @posts = @q.result(distinct: true)
  end

  # GEt /posts/manage
  def manage
    if current_user.admin?
      @posts = Post.all
    else
      @posts = current_user.posts
    end
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
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

  RECOMMENDABLE_METHODS.each do |method|
    define_method(method) do
      @post = Post.find(params[:id])

      if current_user.send(method, @post)
        head :ok
      else
        head :unprocessable_entity
      end
    end
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
    params.require(:post).permit(:title, :text, :annotation, :image_src, :section_id, :user_id, :author, tag_list: [])
  end

  def post_owner
    unless @post.user_id == current_user.id || current_user.admin?
      flash[:notice] = 'Access denied as you are not owner of this job'
      redirect_to posts_path
    end
  end
end

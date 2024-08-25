class PostsController < ApplicationController
  before_action :authenticate_request
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # GET /posts
  def timeline
    @posts = Post.all
  end

  # GET /posts/:id
  def show
    @comments = @post.comments
    @comment = Comment.new  # For the comment form
    # Removed redirect_to posts_timeline_path as it's not needed
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts
  def create
    # Extract parameters from the request
    post_params = {
      title: params[:title],
      body: params[:body]
    }
  
    # Extract and process tags
    tag_names = params[:tag_ids].to_s.split(',').map(&:strip) if params[:tag_ids].present?
    tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }

    Rails.logger.debug "Title: #{post_params[:title]}"
    Rails.logger.debug "Body: #{post_params[:body]}"
    Rails.logger.debug "Tags: #{tags.inspect}"

    
  
    # Build the post object
    @post = current_user.posts.build(post_params)

    @post.tags = tags
  
    # Save the post
    if @post.save
      # Associate tags with the post
      @post.tags = tags
      @post.save
  
      render :timeline  
    else
      flash.now[:alert] = 'Error creating post. Please check your input.'
      render :timeline
    end
  rescue ActionController::ParameterMissing => e
    flash.now[:alert] = 'Missing parameters'
    render :timeline
  end

  # GET /posts/:id/edit
  def edit
  end

  # PATCH/PUT /posts/:id
  def update
    if @post.update(post_params)
      @post.post_tags.destroy_all
      attach_tags(params[:post][:tag_ids].to_s.split(',').map(&:strip))
      render :timeline, notice: 'Post was successfully updated.'
    else
      flash.now[:alert] = 'Error updating post. Please check your input.'
      render :edit
    end
  end

  # DELETE /posts/:id
  def destroy
    @post.destroy
    render :timeline, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    redirect_to timeline_path, alert: 'You are not authorized to perform this action.' unless @post.user == current_user
  end

  def attach_tags(tag_ids)
    tag_ids.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      @post.tags << tag unless @post.tags.include?(tag) # Avoid duplicate entries
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, tag_ids: [])
  end
end

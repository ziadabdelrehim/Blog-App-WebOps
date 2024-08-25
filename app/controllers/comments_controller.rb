class CommentsController < ApplicationController
    before_action :authenticate_request

  
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user
      # Log the parameters and objects for debugging
      logger.info "Comment content: #{@comment.content}"
      logger.info "Post title: #{@post.title}"
      logger.info "User creating comment: #{@comment.user.name} (ID: #{@comment.user.id})"
  
      if @comment.save
        redirect_to posts_timeline_path, notice: 'Comment was successfully created.'
      else
        redirect_to @post, alert: 'Error creating comment.'
      end
    end

  
    def edit
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
    end
    
  
    def update
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
    
      if @comment.update(comment_params)
        redirect_to posts_timeline_path, notice: 'Comment was successfully updated.'
      else
        render :edit
      end
    end
    
  
    def destroy
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
      @comment.destroy
    
      redirect_to posts_timeline_path, notice: 'Comment was successfully deleted.'
    end
    

    def set_post
      @post = Post.find(params[:post_id])
    end
    
      
  
    private
  
    def set_comment
      @comment = Comment.find(params[:id])
    end
  
    def comment_params
      params.require(:comment).permit(:content)
    end

  

  end
  
class CommentsController < ApplicationController
  before_filter :login_required
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to story_path(@comment.story), :notice => 'Comment created'
    else
      @story = @comment.story
      @comments = @story.comments
      render 'stories/show'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to(story_path(@comment.story))
    end
  end
  

end

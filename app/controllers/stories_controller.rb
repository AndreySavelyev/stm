class StoriesController < ApplicationController

  def index
    @stories = Story.all
  end
  
  def new
    @story = Story.new
  end
  
  def create
    @story = Story.new(params[:story])
    if  @story.save
      redirect_to stories_url, :notice => "Story successfully created"
    else
      render "new"
    end 
  end
  
  def edit
    @story = Story.find(params[:id])
  end
  
  def update
    @story = Story.find(params[:id])
    @story.update_attributes(params[:story])
    if @story.save
      redirect_to stories_url, :notice => "Story successfully updated"
    else
      render 'edit'
    end
  end
  
  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to stories_url, :notice => "Story successfully deleted"
  end
  
  def show
    @story = Story.find(params[:id])
  end

end

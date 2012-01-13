class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
  
  validates_presence_of :user_id, :on => :create
  validates_presence_of :story_id, :on => :create
  validates_presence_of :content, :on => :create
  
  state_machine :state, :initial => :new do
    
  end
  
end

class Story < ActiveRecord::Base
  belongs_to :user
  after_create :set_state!
  validates_presence_of :title

  def set_state!
    self.state = "new"
    save
  end
  
  def start!(current_user)
    self.update_attributes({:state => 'started', :user_id => current_user.id})
  end
  
  def finish!
    self.update_attributes(:state => 'finished')
  end
  
  def accept!
    self.update_attributes(:state => 'accepted')
  end
  
  def reject!
    self.update_attributes(:state => 'rejected')
  end
    
end

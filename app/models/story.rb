class Story < ActiveRecord::Base
  belongs_to :user
  after_create :set_state
  
  def set_state
    self.state = "new"
    save
  end

end

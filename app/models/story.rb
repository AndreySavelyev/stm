class Story < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title

  state_machine :state, :initial => :new do

    event :start do
      transition :new => :started
    end
     
    event :finish do
      transition :started => :finished
    end
    
    event :accept do
      transition :finished => :accepted
    end
    
    event :reject do
      transition :finished => :rejected
    end
    
    event :restart do
      transition :rejected => :started
    end

  end
  
  def self.filter(user_id = nil, state = nil)
    if user_id.present? && state.present?
      where(:user_id => user_id, :state => state)
    elsif user_id.present?
      where(:user_id => user_id)
    elsif state.present?
      where(:state => state)
    else
      all
    end
  end
    
end

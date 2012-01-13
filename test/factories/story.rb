FactoryGirl.define do
  factory :story do
    title 'very simple story'
    description 'theatre comedy drama'
    state 'new'
    
    factory :started do
      title 'this is started story'
      description 'description'    
      state 'started'
    end

    factory :finished do
      title 'it is finished story'
      description 'description'
      state 'finished'
    end
    
    
    

  end
  
end
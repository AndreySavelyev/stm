FactoryGirl.define do
  factory :user do
    email 'mail@example.com'
    name 'Barak Obama'
    
    factory :not_registered_user do
      password 'secret'
      password_confirmation 'secret'
    end
    
    factory :not_registered_user_with_invalid_pass do
      password 'secret'
      password_confirmation 'notsecret'
    end

    factory :registered_user do
      password_digest '$2a$10$hOcccvqSWpy2Khfgy80QuODU0QFMOinnKBoG/VjJk0K1IbPfRPsR6'
    end

   
  end  
  
end
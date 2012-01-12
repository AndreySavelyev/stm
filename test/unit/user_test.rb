require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "validations test" do
    user = User.new
    assert user.invalid?
    user.email = "obama@mail.ru"
    assert user.invalid?
    user.password = 'pass'    
    user.password_confirmation = ''
    assert user.invalid?
    user.password_confirmation = 'pass'
    assert user.valid?
  end
  
end

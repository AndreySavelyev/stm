require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create valid user" do
    users_count = User.count
    post :create, :user => {:email => 'mail2mail@mail.ru', :password => '123', :password_confirmation => '123'}
    assert_response :redirect, root_url
    assert_equal "Signed up!", flash[:notice]
    assert_equal User.count, users_count + 1
    assert_equal session[:user_id], User.find_by_email('mail2mail@mail.ru').id
  end
  
  test "try create user with existing email" do
    # 'mail@mail.ru' - user from fixtures
    users_count = User.count
    post :create, :user => {:email => 'mail@mail.ru', :password => '123', :password_confirmation => '123'}
    assert_response :success
    assert_equal User.count, users_count
    assert_equal session[:user_id], nil
  end
  
  test "try create user with different password and password_confirmation" do
    users_count = User.count
    post :create, :user => {:email => 'mail2mail@mail.ru', :password => '123', :password_confirmation => '124'}
    assert_response :success
    assert_equal User.count, users_count
    assert_equal session[:user_id], nil
  end

  test "try create user with blank password and password_confirmation" do
    users_count = User.count
    post :create, :user => {:email => 'mail2mail@mail.ru', :password => '', :password_confirmation => ''}
    assert_response :success
    assert_equal User.count, users_count
    assert_equal session[:user_id], nil
  end

end

require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :redirect
    assert_equal('Successfull logout', flash[:notice])
  end
  
  test "login with correct pass & email" do
    post :create, :email => 'mail@mail.ru', :password => '123'
    assert_response :redirect
    assert_equal User.find_by_email('mail@mail.ru').id, session[:user_id]
  end

  test "login with incorrect pass & correct email" do
    post :create, :email => 'mail@mail.ru', :password => '111'
    assert_equal('Invalid email or password', flash[:alert])
    assert_response :success
    assert_equal session[:user_id], nil 
  end
  
  test "login with incorrect email" do
    post :create, :email => 'unexist@mail.ru', :password => 'pass'
    assert_equal('Invalid email or password', flash[:alert])
    assert_response :success
    assert_equal session[:user_id], nil 
  end

end

require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create valid user" do
    @user = FactoryGirl.attributes_for(:not_registered_user)
    assert_difference "User.count" do
      post :create, :user => @user
    end
    assert_equal "Signed up!", flash[:notice]
    assert_equal session[:user_id], User.find_by_email(@user[:email]).id
    assert_response :redirect, root_url
  end
  
  test "try create user with existing email" do
    @user = FactoryGirl.create(:registered_user)
    assert_no_difference "User.count" do
      post :create, :user => {:email => @user.email, :password => '123', :password_confirmation => '123'}
    end
    assert_response :success
    assert_equal session[:user_id], nil
  end
  
  test "try create user with different password and password_confirmation" do
    @user = FactoryGirl.attributes_for(:not_registered_user_with_invalid_pass)
    assert_no_difference "User.count" do
      post :create, :user => @user
    end
    assert_response :success
    assert_equal session[:user_id], nil
  end

  test "try create user with blank password and password_confirmation" do
    @user = FactoryGirl.attributes_for(:user)
    assert_no_difference "User.count" do
      post :create, :user => @user
    end
    assert_response :success
    assert_equal session[:user_id], nil
  end

end

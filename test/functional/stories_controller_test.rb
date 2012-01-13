require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  
  # crud with login
  test "should get index" do
    login_user
    get :index
    assert_response :success
    assert_not_nil assigns(:stories)
  end

  test "should get new" do
    login_user
    get :new
    assert_response :success
  end

  test "should create story" do
    login_user
    @story = FactoryGirl.build(:story)
    assert_difference('Story.count') do
      post :create, :story => @story.attributes
    end
    assert_redirected_to stories_url
  end

  test "should show story" do
    login_user
    @story = Factory.create(:story)
    get :show, :id => @story.id
    assert_response :success
  end

  test "should get edit" do
    login_user
    @story = Factory.create(:story)
    get :edit, :id => @story.id
    assert_response :success
  end

  test "should update story" do
    login_user
    @story = Factory.create(:story)
    put :update, :id => @story.id, :story => @story.attributes
    assert_redirected_to stories_url
  end

  test "should destroy story" do
    login_user
    @story = Factory.create(:story)
    assert_difference('Story.count', -1) do
      delete :destroy, :id => @story.id
    end
    assert_redirected_to stories_path
  end

  # crud without login
  test "should get index without login" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stories)
  end
  
  test "should get new without login" do
    get :new
    assert_redirected_to login_url
  end
  
  test "should create story without login" do
    @story = FactoryGirl.build(:story)
    post :create, :story => @story.attributes
    assert_redirected_to login_url
  end
  
  test "should show story without login" do
    @story = Factory.create(:story)
    get :show, :id => @story.id
    assert_redirected_to login_url
  end
  
  test "should get edit without login" do
    @story = Factory.create(:story)
    get :edit, :id => @story.id
    assert_redirected_to login_url
  end
  
  test "should update story without login" do
    @story = Factory.create(:story)
    put :update, :id => @story.id, :story => @story.attributes
    assert_redirected_to login_url
  end
  
  test "should destroy story without login" do
    @story = Factory.create(:story)
    assert_no_difference "Story.count" do
      delete :destroy, :id => @story.id
    end
    assert_redirected_to login_url
  end
  # end crud without login

  test "try create not valid story" do
    login_user
    assert_no_difference "Story.count" do
      post :create, :story => {:title => '', :description => 'blabla'}
    end
    assert_response :success
    assert_template :new
  end

  test "try update not valid story" do
    login_user
    @story = FactoryGirl.create(:story)
    @story.title = ''
    put :update, :id => @story.id, :story => @story.attributes
    assert_response :success
    assert_template :edit
  end
  
  test "start story" do
    login_user
    @story = FactoryGirl.create(:story)
    post :start, :id => @story.id
    assert_redirected_to stories_url
    assert_not_equal(@story.state, @story.reload.state)
  end
  
  test "finish story" do
    login_user
    @story = FactoryGirl.create(:started)
    post :finish, :id => @story.id
    assert_redirected_to stories_url
    assert_not_equal(@story.state, @story.reload.state)    
  end
  
  test "accept story" do
    login_user
    @story = FactoryGirl.create(:finished)
    post :accept, :id => @story.id
    assert_redirected_to stories_url
    assert_not_equal(@story.state, @story.reload.state)    
  end
  
  test "reject story" do
    login_user
    @story = FactoryGirl.create(:finished)
    post :reject, :id => @story.id
    assert_redirected_to stories_url
    assert_not_equal(@story.state, @story.reload.state)    
  end
  
  test "filter with both params" do
    login_user
    @user = User.find_by_email(FactoryGirl.attributes_for(:registered_user)[:email])
    @user.stories.create(FactoryGirl.attributes_for(:started))
    @user.stories.create(FactoryGirl.attributes_for(:finished))
    post :filter, :user_id => @user.id, :state => 'finished'
    assert_response :success
    assert_not_nil assigns(:stories)
  end
  
  test "filter with user_id only" do
    login_user
    @user = User.find_by_email(FactoryGirl.attributes_for(:registered_user)[:email])
    @user.stories.create(FactoryGirl.attributes_for(:started))
    @user.stories.create(FactoryGirl.attributes_for(:finished))
    post :filter, :user_id => @user.id, :state => nil
    assert_response :success
    assert_not_nil assigns(:stories)
  end
  
  test "filter with state only" do
    login_user
    FactoryGirl.create(:story)
    post :filter, :user_id => nil, :state => 'started'
    assert_response :success
    assert_not_nil assigns(:stories)
  end
  
  test "filter without both params" do
    login_user
    @user = User.find_by_email(FactoryGirl.attributes_for(:registered_user)[:email])
    @user.stories.create(FactoryGirl.attributes_for(:started))
    @user.stories.create(FactoryGirl.attributes_for(:finished))
    FactoryGirl.create(:story)
    post :filter, :user_id => nil, :state => nil
    assert_response :success
    assert_not_nil assigns(:stories)
    assert_equal Story.count, assigns(:stories).count
  end
  

end

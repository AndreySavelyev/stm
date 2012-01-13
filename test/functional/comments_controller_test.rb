require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  test "create valid comment" do
    login_user
    story = FactoryGirl.create(:story)
    comm = story.comments.new(FactoryGirl.attributes_for(:comment))
    assert_difference "Comment.count", +1 do
      post :create, :comment => comm.attributes
    end
    assert_redirected_to story_path(story)
  end
  
  test "try create invalid comment" do
    login_user
    story = FactoryGirl.create(:story)
    comm = story.comments.new
    assert_no_difference "Comment.count" do
      post :create, :comment => comm.attributes
    end
    assert_response :success
  end
  
  test "delete comment" do
    login_user
    story = FactoryGirl.create(:story)
    user = User.find_by_email(FactoryGirl.attributes_for(:registered_user)[:email])
    comment = story.comments.create(:content  => FactoryGirl.attributes_for(:comment)[:content], 
                                    :story_id => story.id, 
                                    :user_id  => user.id)
    assert_difference "Comment.count", -1 do
      delete :destroy, :id => comment.id
    end
    assert_redirected_to story_path(story)
  end
  
end

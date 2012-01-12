require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "validation test" do
    story = Story.new
    assert story.invalid?
    story.title = 'title'
    assert story.valid?
  end
  
  test "start story" do
    story = stories(:one)
    story.start!(users(:one))
    assert_equal story.state, 'started'
  end
  
  test "finish story" do
    story = stories(:started)
    story.finish!
    assert_equal story.state, 'finished'
  end

  test "accept story" do
    story = stories(:finished)
    story.accept!
    assert_equal story.state, 'accepted'
  end
  
  test "reject story" do
    story = stories(:finished)
    story.reject!
    assert_equal story.state, 'rejected'
  end

end
